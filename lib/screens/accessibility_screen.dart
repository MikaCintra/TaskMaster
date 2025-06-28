import 'package:flutter/material.dart';

class AccessibilityScreen extends StatelessWidget {
  const AccessibilityScreen({super.key});

  void _handleAction(String label) {
    debugPrint('Clicou em: $label');
  }

  Widget _buildFeatureButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton.icon(
        onPressed: () => _handleAction(label),
        icon: Icon(icon, color: Colors.black),
        label: Text(label, style: const TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          minimumSize: const Size.fromHeight(45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mensagem inicial em destaque
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Personalize o app para atender às suas necessidades.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Seção: Visão
                  const Text(
                    'VISÃO',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildFeatureButton(Icons.zoom_in, 'Zoom'),
                        _buildFeatureButton(
                          Icons.text_fields,
                          'Tamanho do texto',
                        ),
                        _buildFeatureButton(Icons.volume_up, 'Conteúdo falado'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Seção: Física e motora
                  const Text(
                    'FÍSICA E MOTORA',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildFeatureButton(Icons.touch_app, 'Toque'),
                        _buildFeatureButton(Icons.mic, 'Controle por voz'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Botão de Início
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Início'),
                    ),
                  ),
                ],
              ),
            ),

            // Botão de ajuda fixo no canto inferior direito
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () => _handleAction('Ajuda'),
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.help_outline, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
