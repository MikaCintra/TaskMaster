import 'package:flutter/material.dart';
import 'package:taskmaster/screens/accessibility_screen.dart';
import 'package:taskmaster/screens/calendar_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _handleTap(BuildContext context, String label) {
    switch (label) {
      case 'Acessibilidade':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AccessibilityScreen()),
        );
        break;
      case 'Calendário':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CalendarScreen()),
        );
        break;
      default:
        debugPrint('Clicou em: $label');
    }
  }

  Widget _buildMenuButton(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.black),
        label: Text(label, style: const TextStyle(color: Colors.black)),
        onPressed: () => _handleTap(context, label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          minimumSize: const Size.fromHeight(45),
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Topo com ícone de menu e avatar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, size: 28),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/1.png'),
                    radius: 20,
                  ),
                ],
              ),
            ),

            // Card central com gradiente vermelho
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Colors.redAccent, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(Icons.star_border, color: Colors.black, size: 36),
              ),
            ),

            // Lista de botões
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 20),
                children: [
                  _buildMenuButton(
                    context,
                    Icons.notifications,
                    'Notificações',
                  ),
                  _buildMenuButton(context, Icons.language, 'Idioma'),
                  _buildMenuButton(context, Icons.brightness_6, 'Modo Noturno'),
                  _buildMenuButton(context, Icons.star, 'Favoritos'),
                  _buildMenuButton(context, Icons.person, 'Meu Perfil'),
                  _buildMenuButton(context, Icons.calendar_today, 'Calendário'),
                  _buildMenuButton(context, Icons.share, 'Compartilhamento'),
                  _buildMenuButton(context, Icons.show_chart, 'Progresso'),
                  _buildMenuButton(
                    context,
                    Icons.accessibility,
                    'Acessibilidade',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
