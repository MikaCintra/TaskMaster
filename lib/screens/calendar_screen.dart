// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: CalendarScreen()),
  );
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _dataSelecionada = DateTime.now();
  final Map<String, List<Map<String, dynamic>>> _tarefasPorData = {};

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  String _formatarData(DateTime data) =>
      '${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}';

  String _formatarDataExtensa(DateTime data) {
    final formato = DateFormat('EEE, MMM d', 'pt_BR');
    return formato.format(data);
  }

  List<Map<String, dynamic>> get _tarefasDoDia {
    final chave = _formatarData(_dataSelecionada);
    return _tarefasPorData[chave] ?? [];
  }

  Future<void> salvarTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_tarefasPorData);
    await prefs.setString('tarefasPorData', jsonString);
  }

  Future<void> carregarTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('tarefasPorData');
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      setState(() {
        _tarefasPorData.clear();
        jsonMap.forEach((key, value) {
          _tarefasPorData[key] = List<Map<String, dynamic>>.from(value);
        });
      });
    }
  }

  void _adicionarOuEditarTarefa({int? index}) {
    final TextEditingController textoController = TextEditingController();
    final TextEditingController horaController = TextEditingController();

    if (index != null) {
      final tarefa = _tarefasDoDia[index];
      final partes = tarefa['texto'].split(' - ');
      if (partes.length == 2) {
        horaController.text = partes[0];
        textoController.text = partes[1];
      }
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          index == null ? 'Nova Tarefa' : 'Editar Tarefa',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: horaController,
              decoration: InputDecoration(
                labelText: 'Horário (HH:mm)',
                labelStyle: TextStyle(color: Colors.white70),
              ),
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: textoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                labelStyle: TextStyle(color: Colors.white70),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Salvar'),
            onPressed: () async {
              final texto = textoController.text;
              final hora = horaController.text;
              if (texto.isNotEmpty && hora.isNotEmpty) {
                final chave = _formatarData(_dataSelecionada);
                setState(() {
                  _tarefasPorData.putIfAbsent(chave, () => []);
                  final novaTarefa = {
                    'hora': hora,
                    'texto': '$hora - $texto',
                    'icone': 'Icons.task',
                    'cor': 'grey',
                  };
                  if (index == null) {
                    _tarefasPorData[chave]!.add(novaTarefa);
                  } else {
                    _tarefasPorData[chave]![index] = novaTarefa;
                  }
                  _tarefasPorData[chave]!.sort(
                    (a, b) => a['hora'].compareTo(b['hora']),
                  );
                });
                await salvarTarefas();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _excluirTarefa(int index) async {
    final chave = _formatarData(_dataSelecionada);
    setState(() {
      _tarefasPorData[chave]!.removeAt(index);
    });
    await salvarTarefas();
  }

  IconData _getIcon(String nome) {
    switch (nome) {
      case 'Icons.water_drop':
        return Icons.water_drop;
      case 'Icons.cut':
        return Icons.cut;
      case 'Icons.computer':
        return Icons.computer;
      case 'Icons.emoji_emotions':
        return Icons.emoji_emotions;
      default:
        return Icons.task;
    }
  }

  Color _getColor(String nome) {
    switch (nome) {
      case 'blue':
        return Colors.blue;
      case 'grey':
        return Colors.grey;
      case 'purple':
        return Colors.purpleAccent;
      case 'yellow':
        return Colors.yellowAccent;
      case 'green':
        return Colors.greenAccent;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Escolha a data',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _formatarDataExtensa(_dataSelecionada),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(Icons.edit, color: Colors.white70),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TableCalendar(
                      focusedDay: _dataSelecionada,
                      firstDay: DateTime(2020),
                      lastDay: DateTime(2030),
                      calendarFormat: CalendarFormat.month,
                      selectedDayPredicate: (day) =>
                          isSameDay(day, _dataSelecionada),
                      onDaySelected: (selectedDay, _) {
                        setState(() {
                          _dataSelecionada = selectedDay;
                        });
                      },
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                        titleTextStyle: TextStyle(color: Colors.white),
                      ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: TextStyle(color: Colors.white),
                        weekendTextStyle: TextStyle(color: Colors.white70),
                        selectedDecoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.white24,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ClipPath(
              clipper: TasksCurveClipper(),
              child: Container(
                color: Colors.black87,
                padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tarefas de hoje:',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _adicionarOuEditarTarefa(),
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.greenAccent,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ..._tarefasDoDia.asMap().entries.map((entry) {
                      final i = entry.key;
                      final tarefa = entry.value;
                      return TaskItem(
                        icon: _getIcon(tarefa['icone']),
                        color: _getColor(tarefa['cor']),
                        text: tarefa['texto'],
                        onEdit: () => _adicionarOuEditarTarefa(index: i),
                        onDelete: () => _excluirTarefa(i),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskItem({
    required this.icon,
    required this.color,
    required this.text,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(widget.icon, color: widget.color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.text,
              style: TextStyle(
                color: _checked ? Colors.white54 : Colors.white,
                decoration: _checked ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          Checkbox(
            value: _checked,
            activeColor: Colors.greenAccent,
            checkColor: Colors.black,
            onChanged: (value) {
              setState(() {
                _checked = value ?? false;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.edit, size: 20, color: Colors.white54),
            onPressed: widget.onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete, size: 20, color: Colors.redAccent),
            onPressed: widget.onDelete,
          ),
        ],
      ),
    );
  }
}

class TasksCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 20);
    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.5, 20);
    path.quadraticBezierTo(size.width * 0.75, 40, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
