import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  Map<DateTime, List<Map<String, dynamic>>> tarefasPorDia = {};
  final Map<int, String> anotacoes = {};
  DateTime diaSelecionado = DateTime.now();
  int? notaSelecionada;
  final diasSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  Future<void> _carregarTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tarefasSalvas');
    if (data != null) {
      final decoded = Map<String, dynamic>.from(jsonDecode(data));
      setState(() {
        tarefasPorDia = decoded.map(
          (k, v) => MapEntry(
            DateTime.parse(k),
            List<Map<String, dynamic>>.from(
              v.map((i) => Map<String, dynamic>.from(i)),
            ),
          ),
        );
      });
    }
  }

  Future<void> _salvarTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    final data = tarefasPorDia.map((k, v) => MapEntry(k.toIso8601String(), v));
    await prefs.setString('tarefasSalvas', jsonEncode(data));
  }

  List<Map<String, dynamic>> _tarefasDoDia(DateTime dia) {
    return tarefasPorDia[dia] ?? [];
  }

  IconData _definirIcone(String nome) {
    final nomeLower = nome.toLowerCase();
    if (nomeLower.contains('água')) return Icons.water_drop;
    if (nomeLower.contains('estudar')) return Icons.menu_book;
    if (nomeLower.contains('academia')) return Icons.fitness_center;
    if (nomeLower.contains('shopping')) return Icons.shopping_bag;
    if (nomeLower.contains('supermercado') || nomeLower.contains('mercado'))
      return Icons.local_grocery_store;
    if (nomeLower.contains('cachorro')) return Icons.pets;
    return Icons.task;
  }

  void _adicionarOuEditarTarefa({
    Map<String, dynamic>? tarefaExistente,
    int? index,
  }) {
    final nomeController = TextEditingController(
      text: tarefaExistente?['nome'] ?? '',
    );
    DateTime? dataSelecionada = diaSelecionado;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            tarefaExistente != null ? 'Editar Tarefa' : 'Nova Tarefa',
          ),
          content: TextField(
            controller: nomeController,
            decoration: const InputDecoration(labelText: 'Nome da tarefa'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final nome = nomeController.text.trim();
                if (nome.isNotEmpty) {
                  setState(() {
                    final nova = {
                      'nome': nome,
                      'feito': false,
                      'icone': _definirIcone(nome),
                    };
                    tarefasPorDia.putIfAbsent(dataSelecionada!, () => []);
                    if (tarefaExistente != null && index != null) {
                      tarefasPorDia[dataSelecionada!]![index] = nova;
                    } else {
                      tarefasPorDia[dataSelecionada!]!.add(nova);
                    }
                  });
                  _salvarTarefas();
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _excluirTarefa(int index) {
    setState(() {
      tarefasPorDia[diaSelecionado]!.removeAt(index);
      _salvarTarefas();
    });
  }

  Widget _noteCard(int index, Color color) {
    final isExpanded = notaSelecionada == index;
    final anotacao = anotacoes[index] ?? '';

    return GestureDetector(
      onTap: () {
        setState(() => notaSelecionada = isExpanded ? null : index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isExpanded ? 180 : 40,
        height: isExpanded ? 150 : 60,
        padding: isExpanded ? const EdgeInsets.all(8) : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: isExpanded
            ? TextField(
                maxLines: null,
                expands: true,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Escreva algo...',
                ),
                onChanged: (v) => anotacoes[index] = v,
              )
            : anotacoes.containsKey(index)
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    anotacoes[index]!,
                    style: const TextStyle(fontSize: 10),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tarefasHoje = _tarefasDoDia(diaSelecionado);

    return GestureDetector(
      onTap: () => setState(() => notaSelecionada = null),
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          children: [
            TableCalendar(
              locale: 'pt_BR',
              focusedDay: diaSelecionado,
              firstDay: DateTime(2020),
              lastDay: DateTime(2100),
              calendarFormat: CalendarFormat.week,
              onDaySelected: (selectedDay, _) {
                setState(() => diaSelecionado = selectedDay);
              },
              selectedDayPredicate: (day) => isSameDay(day, diaSelecionado),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _adicionarOuEditarTarefa(),
                icon: const Icon(Icons.add),
                label: const Text('Nova tarefa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(200, 45),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: tarefasHoje.isEmpty
                  ? const Center(
                      child: Text(
                        'Sem tarefas para este dia',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tarefasHoje.length,
                      itemBuilder: (_, i) {
                        final tarefa = tarefasHoje[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: Icon(
                                tarefa['icone'],
                                color: Colors.white,
                              ),
                              title: Text(
                                tarefa['nome'],
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: tarefa['feito']
                                      ? TextDecoration.lineThrough
                                      : null,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: tarefa['feito'],
                                    onChanged: (val) {
                                      setState(() {
                                        tarefa['feito'] = val;
                                        _salvarTarefas();
                                      });
                                    },
                                    checkColor: Colors.white,
                                    activeColor: Colors.green,
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => _adicionarOuEditarTarefa(
                                      tarefaExistente: tarefa,
                                      index: i,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () => _excluirTarefa(i),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text(
                'Anotações',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (i) {
                final cores = [
                  Colors.greenAccent,
                  Colors.purpleAccent,
                  Colors.yellow,
                  Colors.redAccent,
                  Colors.cyanAccent,
                ];
                return _noteCard(i, cores[i]);
              }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
