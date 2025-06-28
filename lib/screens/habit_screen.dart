import 'package:flutter/material.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final List<String> categorias = [
    'Todas',
    'Saúde',
    'Lazer',
    'Casa',
    'Amigos',
    'Família',
    'Trabalho',
  ];

  final Map<String, List<String>> habitosPorCategoria = {
    'Saúde': [
      'Beber água',
      'Fazer exercício',
      'Tomar vitaminas',
      'Ir para academia',
      'Comer frutas',
    ],
    'Lazer': [
      'Ler livro',
      'Sair pra comer',
      'Assistir filme',
      'Ouvir música',
      'Desenhar',
    ],
    'Casa': [
      'Limpar a casa',
      'Organizar tarefas',
      'Lavar roupa',
      'Cozinhar',
      'Cuidar das plantas',
    ],
    'Amigos': [
      'Conversar com um amigo',
      'Marcar um encontro',
      'Enviar mensagem',
      'Fazer ligação',
      'Compartilhar uma memória',
    ],
    'Família': [
      'Ligar para os pais',
      'Ajudar em casa',
      'Almoçar junto',
      'Planejar viagem',
      'Brincar com irmãos',
    ],
    'Trabalho': [
      'Planejar semana',
      'Estudar 1h',
      'Anotar gratidão',
      'Meditar 10 minutos',
      'Dormir cedo',
    ],
  };

  late List<bool> habitosSelecionados;
  String categoriaSelecionada = 'Todas';

  @override
  void initState() {
    super.initState();
    _atualizarHabitosSelecionados();
  }

  void _atualizarHabitosSelecionados() {
    final habitos = _habitosFiltrados();
    habitosSelecionados = List<bool>.filled(habitos.length, false);
  }

  List<String> _habitosFiltrados() {
    if (categoriaSelecionada == 'Todas') {
      return habitosPorCategoria.values.expand((list) => list).toList();
    } else {
      return habitosPorCategoria[categoriaSelecionada] ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final habitos = _habitosFiltrados();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                        categoriaSelecionada = cat;
                        _atualizarHabitosSelecionados();
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
                _buildImageCard('assets/images/4.png'),
                _buildImageCard('assets/images/5.png'),
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
