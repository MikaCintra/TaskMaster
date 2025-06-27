import 'package:flutter/material.dart';

class HabitScreen extends StatelessWidget {
  const HabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo hábito'), backgroundColor: Colors.black),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Text('Saúde')),
              Expanded(child: Text('Casa')),
              Expanded(child: Text('Amigos')),
              Expanded(child: Text('Trabalho')),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.local_drink)),
                  title: Text('Beber água'),
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.fitness_center)),
                  title: Text('Fazer exercício'),
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.vaccines)),
                  title: Text('Tomar vitaminas'),
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.local_fire_department),
                  ),
                  title: Text('Ler livro'),
                ),
                // Adicione mais itens conforme necessário
              ],
            ),
          ),
        ],
      ),
      //floatingActionButton: FloatingActionButton(
      // onPressed: () {
      //Navigator.push(
      // context,
      // MaterialPageRoute(builder: (context) => MenuScreen()),
      //  );
      // },
      // child: Icon(Icons.check),
      // backgroundColor: Colors.green,
      //),
    );
  }
}
