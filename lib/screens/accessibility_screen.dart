import 'package:flutter/material.dart';

class AccessibilityScreen extends StatelessWidget {
  const AccessibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acessibilidade'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personalize o app atender as suas necessidades.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text('VISÃO', style: TextStyle(fontWeight: FontWeight.bold)),
            ListTile(
              leading: Icon(Icons.zoom_in),
              title: Text('Zoom'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.text_fields),
              title: Text('Tamanho do texto'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.hearing),
              title: Text('Contraste elevado'),
              onTap: () {},
            ),
            Text(
              'FÍSICA E MOTORA',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.touch_app),
              title: Text('Toque'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.voice_chat),
              title: Text('Controle por voz'),
              onTap: () {},
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Início'),
            ),
          ],
        ),
      ),
    );
  }
}
