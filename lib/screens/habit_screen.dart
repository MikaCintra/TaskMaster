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
      'Dormir 8 horas',
      'Meditar',
      'Comer frutas',
      'Alongar',
      'Caminhar ao ar livre',
    ],
    'Lazer': [
      'Ler livro',
      'Assistir filme',
      'Ouvir música',
      'Jogar videogame',
      'Desenhar',
      'Cozinhar algo novo',
      'Passear no parque',
    ],
    'Casa': [
      'Limpar a casa',
      'Organizar armário',
      'Regar plantas',
      'Lavar louça',
      'Trocar roupa de cama',
      'Cuidar do lixo',
      'Passar pano no chão',
    ],
    'Amigos': [
      'Conversar com um amigo',
      'Marcar encontro',
      'Enviar mensagem',
      'Jogar online',
      'Fazer chamada de vídeo',
      'Comentar em rede social',
      'Compartilhar uma lembrança',
    ],
    'Família': [
      'Ligar para os pais',
      'Almoçar junto',
      'Ajudar em casa',
      'Planejar passeio',
      'Contar uma novidade',
      'Ver fotos antigas',
      'Assistir TV juntos',
    ],
    'Trabalho': [
      'Planejar semana',
      'Responder e-mails',
      'Revisar tarefas',
      'Estudar algo novo',
      'Fazer reunião',
      'Organizar mesa',
      'Atualizar agenda',
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

  void _mostrarDialogoAdicionarHabito() {
    String? categoriaEscolhida = categorias.firstWhere(
      (c) => c != 'Todas',
      orElse: () => 'Saúde',
    );
    final TextEditingController nomeController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Adicionar novo hábito'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: categoriaEscolhida,
              isExpanded: true,
              items: categorias
                  .where((c) => c != 'Todas')
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  categoriaEscolhida = value;
                });
              },
            ),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome do hábito'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final nome = nomeController.text.trim();
              if (nome.isNotEmpty && categoriaEscolhida != null) {
                setState(() {
                  habitosPorCategoria[categoriaEscolhida!]!.add(nome);
                  _atualizarHabitosSelecionados();
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoEditarHabito(
    String categoria,
    int index,
    String nomeAtual,
  ) {
    final TextEditingController nomeController = TextEditingController(
      text: nomeAtual,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar hábito'),
        content: TextField(
          controller: nomeController,
          decoration: const InputDecoration(labelText: 'Novo nome'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final novoNome = nomeController.text.trim();
              if (novoNome.isNotEmpty) {
                setState(() {
                  habitosPorCategoria[categoria]![index] = novoNome;
                  _atualizarHabitosSelecionados();
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
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

          const SizedBox(
            height: 36,
          ), // Espaçamento maior entre categorias e imagens
          // Imagens
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

          const SizedBox(height: 16),

          // Lista de hábitos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: habitos.length,
              itemBuilder: (context, index) {
                final nome = habitos[index];
                final categoria = habitosPorCategoria.entries
                    .firstWhere((entry) => entry.value.contains(nome))
                    .key;
                final itemIndex = habitosPorCategoria[categoria]!.indexOf(nome);

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple[100],
                    child: Text(nome[0].toUpperCase()),
                  ),
                  title: Text(nome),
                  trailing: Wrap(
                    spacing: 4,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _mostrarDialogoEditarHabito(
                          categoria,
                          itemIndex,
                          nome,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            habitosPorCategoria[categoria]!.removeAt(itemIndex);
                            _atualizarHabitosSelecionados();
                          });
                        },
                      ),
                      Checkbox(
                        value: habitosSelecionados[index],
                        onChanged: (value) {
                          setState(() {
                            habitosSelecionados[index] = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoAdicionarHabito,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
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
