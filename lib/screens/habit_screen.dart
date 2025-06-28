import 'package:flutter/material.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final List<String> categorias = [
    'Saúde',
    'Lazer',
    'Casa',
    'Amigos',
    'Família',
    'Trabalho',
  ];

  final List<String> habitos = [
    'Beber água',
    'Fazer exercício',
    'Tomar vitaminas',
    'Ler livro',
    'Acordar cedo',
    'Limpar a casa',
    'Sair pra comer',
    'Ir para academia',
    'Passear com o cachorro',
    'Comer frutas',
    'Meditar 10 minutos',
    'Anotar gratidão',
    'Fazer caminhada',
    'Organizar tarefas',
    'Planejar semana',
    'Dormir cedo',
    'Evitar celular à noite',
    'Estudar 1h',
    'Fazer skincare',
    'Conversar com alguém querido',
  ];

  late List<bool> habitosSelecionados;
  String? categoriaSelecionada;

  @override
  void initState() {
    super.initState();
    habitosSelecionados = List<bool>.filled(habitos.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Botões de categorias
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: categorias.map((cat) {
                final isSelected = cat == categoriaSelecionada;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected
                          ? Colors.deepPurple
                          : Colors.grey[200],
                      foregroundColor: isSelected ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        categoriaSelecionada = isSelected
                            ? null
                            : cat; // toggle
                      });
                    },
                    child: Text(cat),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 12),

          // Cards com imagens
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildImageCard('assets/images/1.png'),
                _buildImageCard('assets/images/2.png'),
                _buildImageCard('assets/images/3.png'),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Lista de hábitos com checkboxes
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: habitos.length,
              itemBuilder: (context, index) {
                final letra = habitos[index][0].toUpperCase();
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple[100],
                    child: Text(
                      letra,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  title: Text(habitos[index]),
                  trailing: Checkbox(
                    value: habitosSelecionados[index],
                    onChanged: (bool? value) {
                      setState(() {
                        habitosSelecionados[index] = value ?? false;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String imagePath) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            debugPrint('Erro ao carregar: $imagePath');
          },
        ),
      ),
    );
  }
}
