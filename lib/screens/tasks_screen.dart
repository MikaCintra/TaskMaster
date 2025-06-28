import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para kIsWeb

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton.icon(
              onPressed: () {
                // Lógica de criação de nova tarefa
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Nova tarefa'),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                taskTile(Icons.water_drop, 'Beber 3L de água'),
                taskTile(Icons.cut, '08H - Cortar cabelo'),
                taskTile(Icons.tv, '09h - Aula de Inglês'),
                taskTile(Icons.restaurant, '11h - Almoçar'),
                taskTile(Icons.fitness_center, '13h - Academia'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Crie anotações',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              noteCard(Colors.greenAccent),
              noteCard(Colors.purpleAccent),
              noteCard(Colors.yellow),
              noteCard(Colors.redAccent),
              noteCard(Colors.cyanAccent),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  static Widget taskTile(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
          trailing: Checkbox(
            value: false,
            onChanged: (_) {},
            checkColor: Colors.white,
            activeColor: Colors.green,
          ),
        ),
      ),
    );
  }

  static Widget noteCard(Color color) {
    return Container(
      width: 40,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
