import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  double _fontSize = 16.0;

  @override
  void initState() {
    super.initState();
    _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    });
  }

  Future<void> _saveFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', _fontSize);
  }

  void _adjustFontSize(bool increase) {
    setState(() {
      _fontSize = (increase ? _fontSize + 2 : _fontSize - 2).clamp(12.0, 32.0);
    });
    _saveFontSize();
  }

  Widget _buildZoomRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.zoom_in, color: Colors.black),
            const SizedBox(width: 8),
            const Text('Zoom', style: TextStyle(color: Colors.black)),
            const Spacer(),
            IconButton(
              onPressed: () => _adjustFontSize(false),
              icon: const Icon(Icons.remove, color: Colors.black),
            ),
            IconButton(
              onPressed: () => _adjustFontSize(true),
              icon: const Icon(Icons.add, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestoreButton() {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          _fontSize = 16.0;
        });
        _saveFontSize();
      },
      icon: const Icon(Icons.restore, color: Colors.black),
      label: const Text(
        'Restaurar padrão',
        style: TextStyle(color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        minimumSize: const Size.fromHeight(40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _buildFeatureButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton.icon(
        onPressed: () => debugPrint('Clicou em $label'),
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Personalize o app para atender às suas necessidades.',
                      style: TextStyle(
                        fontSize: _fontSize,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'VISÃO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _fontSize + 2,
                    ),
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
                        _buildZoomRow(),
                        const SizedBox(height: 8),
                        _buildRestoreButton(),
                        _buildFeatureButton(
                          Icons.text_fields,
                          'Tamanho do texto',
                        ),
                        _buildFeatureButton(Icons.volume_up, 'Conteúdo falado'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'FÍSICA E MOTORA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _fontSize + 2,
                    ),
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
                      child: Text(
                        'Sair',
                        style: TextStyle(fontSize: _fontSize),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () => debugPrint('Ajuda'),
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
