import 'package:flutter/material.dart';
import 'accessibility_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu'), backgroundColor: Colors.black),
      body: ListView(
        children: [
          Container(
            color: Colors.red,
            height: 100,
            child: Center(
              child: Icon(Icons.home, color: Colors.white, size: 40),
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificações'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Idioma'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text('Modo Noturno'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Favoritos'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Meu Perfil'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Calendário'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Compartilhamento'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.show_chart),
            title: Text('Progresso'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.accessibility),
            title: Text('Acessibilidade'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccessibilityScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
