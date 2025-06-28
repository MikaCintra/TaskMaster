import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Dados do usuário
  String _nome = 'Beatriz Silva';
  int _idade = 22;
  String _cidade = 'São Paulo - SP';

  // Pontuações dos hábitos
  final Map<String, double> _habitos = {
    'Beber água': 8.5,
    'Estudo diário': 9.2,
    'Atividade física': 7.0,
    'Sono regular': 6.8,
    'Socialização': 8.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black, // Fundo preto para contraste
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Foto
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/1.png'),
              ),
              const SizedBox(height: 16),

              // Formulário de dados
              TextFormField(
                initialValue: _nome,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _nome = value,
              ),
              TextFormField(
                initialValue: _idade.toString(),
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _idade = int.tryParse(value) ?? _idade,
              ),
              TextFormField(
                initialValue: _cidade,
                decoration: const InputDecoration(
                  labelText: 'Cidade',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _cidade = value,
              ),
              const SizedBox(height: 24),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pontuação de hábitos',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),

              ..._habitos.entries.map((entry) => _buildHabitSlider(entry.key)),

              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Perfil atualizado com sucesso!'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text(
                  'Voltar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHabitSlider(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${_habitos[label]!.toStringAsFixed(1)}',
          style: const TextStyle(color: Colors.white),
        ),
        Slider(
          value: _habitos[label]!,
          min: 0,
          max: 10,
          divisions: 20,
          label: _habitos[label]!.toStringAsFixed(1),
          onChanged: (value) {
            setState(() {
              _habitos[label] = value;
            });
          },
        ),
      ],
    );
  }
}
