import 'package:flutter/material.dart';
import 'tasks_screen.dart';
import 'widgets/task_item.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendário'), backgroundColor: Colors.black),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Escolha a data', style: TextStyle(color: Colors.white)),
                Text(
                  'Qui, Ago 17',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            child: Table(
              children: [
                TableRow(
                  children: [
                    Text('D', style: TextStyle(color: Colors.white)),
                    Text('S', style: TextStyle(color: Colors.white)),
                    Text('T', style: TextStyle(color: Colors.white)),
                    Text('Q', style: TextStyle(color: Colors.white)),
                    Text('Q', style: TextStyle(color: Colors.white)),
                    Text('S', style: TextStyle(color: Colors.white)),
                    Text('S', style: TextStyle(color: Colors.white)),
                  ],
                ),
                TableRow(
                  children: [
                    Text('1', style: TextStyle(color: Colors.white)),
                    Text('2', style: TextStyle(color: Colors.white)),
                    Text('3', style: TextStyle(color: Colors.white)),
                    Text('4', style: TextStyle(color: Colors.white)),
                    Text('5', style: TextStyle(color: Colors.white)),
                    Text('6', style: TextStyle(color: Colors.white)),
                    Text('7', style: TextStyle(color: Colors.white)),
                  ],
                ),
                // Adicione mais linhas conforme necessário
              ],
            ),
          ),
          Expanded(child: TasksScreen()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
