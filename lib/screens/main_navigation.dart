import 'package:flutter/material.dart';
import 'package:taskmaster/screens/menu_screen.dart';
import 'package:taskmaster/screens/calendar_screen.dart';
import 'package:taskmaster/screens/tasks_screen.dart';
import 'package:taskmaster/screens/habit_screen.dart';
import 'package:taskmaster/screens/accessibility_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  final List<String> _titles = [
    'Menu',
    'Calendário',
    'Nova Tarefa',
    'Novo Hábito',
    'Acessibilidade',
  ];

  @override
  void initState() {
    super.initState();
    _screens = [
      const MenuScreen(),
      const CalendarScreen(),
      const TasksScreen(),
      const HabitScreen(),
      const AccessibilityScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: Colors.black,
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Menu'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendário',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tarefa'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Hábito'),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'Acessibilidade',
          ),
        ],
      ),
    );
  }
}
