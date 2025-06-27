import 'package:flutter/material.dart';
import 'package:taskmaster/widgets/task_item.dart';
import 'package:taskmaster/screens/habit_screen.dart';
import 'widgets/task_item.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black,
          padding: EdgeInsets.all(10),
          child: Text(
            'Tarefas hoje:',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              TaskItem(
                icon: Icons.water_drop,
                time: '08h',
                task: 'Beber 2L de água',
              ),
              TaskItem(icon: Icons.cut, time: '08h', task: 'Cortar cabelo'),
              TaskItem(icon: Icons.tv, time: '09h', task: 'Aula de Inglês'),
              TaskItem(icon: Icons.restaurant, time: '11h', task: 'Almoçar'),
              TaskItem(icon: Icons.school, time: '13h', task: 'Academia'),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HabitScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: Size(double.infinity, 50),
          ),
          child: Text('Nova tarefa'),
        ),
      ],
    );
  }
}
