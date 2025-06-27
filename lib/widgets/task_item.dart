import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final IconData icon;
  final String time;
  final String task;

  const TaskItem({
    super.key, // Parâmetro 'key' para widgets públicos
    required this.icon,
    required this.time,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text('$time - $task'),
      trailing: Checkbox(value: false, onChanged: (value) {}),
    );
  }
}
