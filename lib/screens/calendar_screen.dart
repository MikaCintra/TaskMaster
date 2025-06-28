import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';

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
    _tarefasPorData.addAll({
      "2024-07-03": [
        {
          "hora": "10:00",
          "texto": "10:00 - Estudo de SQL",
          "icone": "Icons.computer",
          "cor": "yellow",
        },
      ],
      "2024-07-05": [
        {
          "hora": "11:00",
          "texto": "11:00 - Revisar código Flutter",
          "icone": "Icons.computer",
          "cor": "blue",
        },
      ],
      "2024-07-08": [
        {
          "hora": "13:00",
          "texto": "13:00 - Reunião com equipe",
          "icone": "Icons.emoji_emotions",
          "cor": "green",
        },
      ],
      "2024-07-10": [
        {
          "hora": "09:00",
          "texto": "09:00 - Fazer backup",
          "icone": "Icons.cut",
          "cor": "grey",
        },
      ],
      "2024-07-12": [
        {
          "hora": "08:30",
          "texto": "08:30 - Caminhada matinal",
          "icone": "Icons.emoji_emotions",
          "cor": "purple",
        },
      ],
      "2024-07-15": [
        {
          "hora": "16:00",
          "texto": "16:00 - Aula de inglês",
          "icone": "Icons.computer",
          "cor": "yellow",
        },
      ],
      "2024-07-17": [
        {
          "hora": "15:30",
          "texto": "15:30 - Atualizar documentação",
          "icone": "Icons.cut",
          "cor": "green",
        },
      ],
      "2024-07-19": [
        {
          "hora": "10:15",
          "texto": "10:15 - Consultar professor",
          "icone": "Icons.emoji_emotions",
          "cor": "blue",
        },
      ],
      "2024-07-21": [
        {
          "hora": "12:00",
          "texto": "12:00 - Revisar cronograma",
          "icone": "Icons.cut",
          "cor": "grey",
        },
      ],
      "2024-07-23": [
        {
          "hora": "14:00",
          "texto": "14:00 - Fazer checklist projeto",
          "icone": "Icons.computer",
          "cor": "purple",
        },
      ],
      "2024-07-25": [
        {
          "hora": "17:00",
          "texto": "17:00 - Estudar banco de dados",
          "icone": "Icons.computer",
          "cor": "blue",
        },
      ],
      "2024-07-27": [
        {
          "hora": "09:30",
          "texto": "09:30 - Preparar apresentação",
          "icone": "Icons.emoji_emotions",
          "cor": "green",
        },
      ],
      "2024-07-28": [
        {
          "hora": "11:45",
          "texto": "11:45 - Leitura técnica",
          "icone": "Icons.cut",
          "cor": "yellow",
        },
      ],
      "2024-07-29": [
        {
          "hora": "10:00",
          "texto": "10:00 - Desenvolver protótipo",
          "icone": "Icons.computer",
          "cor": "grey",
        },
      ],
      "2024-07-30": [
        {
          "hora": "13:20",
          "texto": "13:20 - Refatorar layout",
          "icone": "Icons.cut",
          "cor": "blue",
        },
      ],
      "2024-08-01": [
        {
          "hora": "08:00",
          "texto": "08:00 - Criar testes unitários",
          "icone": "Icons.computer",
          "cor": "purple",
        },
      ],
      "2024-08-03": [
        {
          "hora": "09:00",
          "texto": "09:00 - Participar de workshop",
          "icone": "Icons.emoji_emotions",
          "cor": "yellow",
        },
      ],
      "2024-08-05": [
        {
          "hora": "14:30",
          "texto": "14:30 - Acompanhar entrega",
          "icone": "Icons.cut",
          "cor": "blue",
        },
      ],
      "2024-08-07": [
        {
          "hora": "15:00",
          "texto": "15:00 - Implementar API",
          "icone": "Icons.computer",
          "cor": "green",
        },
      ],
      "2024-08-09": [
        {
          "hora": "10:30",
          "texto": "10:30 - Validar requisitos",
          "icone": "Icons.cut",
          "cor": "grey",
        },
      ],
    });
  }

  String _formatarData(DateTime data) =>
      '${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}';

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

  void _adicionarTarefa() {
    final TextEditingController textoController = TextEditingController();
    final TextEditingController horaController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Nova Tarefa', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: horaController,
              decoration: const InputDecoration(
                labelText: 'Horário (HH:mm)',
                labelStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            TextField(
              controller: textoController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                labelStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Adicionar'),
            onPressed: () async {
              final texto = textoController.text;
              final hora = horaController.text;

              if (texto.isNotEmpty && hora.isNotEmpty) {
                final chave = _formatarData(_dataSelecionada);
                setState(() {
                  _tarefasPorData.putIfAbsent(chave, () => []);
                  _tarefasPorData[chave]!.add({
                    'hora': hora,
                    'texto': '$hora - $texto',
                    'icone': 'Icons.task',
                    'cor': 'green',
                  });
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
                    const Text(
                      'Escolha a data',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    TableCalendar(
                      focusedDay: _dataSelecionada,
                      firstDay: DateTime(2020),
                      lastDay: DateTime(2030),
                      calendarFormat: CalendarFormat.month,
                      selectedDayPredicate: (day) =>
                          isSameDay(day, _dataSelecionada),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _dataSelecionada = selectedDay;
                        });
                      },
                      headerStyle: const HeaderStyle(
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
                      ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: const TextStyle(color: Colors.white),
                        weekendTextStyle: const TextStyle(
                          color: Colors.white70,
                        ),
                        todayDecoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, date, _) {
                          final dataFormatada = _formatarData(date);
                          final bool temTarefa = _tarefasPorData.containsKey(
                            dataFormatada,
                          );
                          final bool isSelecionado = isSameDay(
                            date,
                            _dataSelecionada,
                          );

                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                '${date.day}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              if (temTarefa)
                                const Positioned(
                                  bottom: 4,
                                  child: Icon(
                                    Icons.circle,
                                    size: 6,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                              if (isSelecionado)
                                const Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 14,
                                    color: Colors.green,
                                  ),
                                ),
                            ],
                          );
                        },
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
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Tarefas de hoje:',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        IconButton(
                          onPressed: _adicionarTarefa,
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.greenAccent,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _tarefasDoDia.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              'O que pretende fazer hoje?',
                              style: TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          )
                        : Column(
                            children: _tarefasDoDia
                                .map(
                                  (tarefa) => TaskItem(
                                    icon: _getIcon(tarefa['icone']),
                                    color: _getColor(tarefa['cor']),
                                    text: tarefa['texto'],
                                  ),
                                )
                                .toList(),
                          ),
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

  const TaskItem({
    required this.icon,
    required this.color,
    required this.text,
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
        borderRadius: BorderRadius.circular(8),
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
