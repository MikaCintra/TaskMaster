import 'package:flutter/material.dart';
import 'main_navigation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // <- fundo branco para toda a tela
      body: Stack(
        children: [
          // Fundo curvo preto
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: TopCurveClipper(),
              child: Container(height: 250, color: Colors.black),
            ),
          ),

          // Conteúdo principal abaixo da curva
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(40, 200, 40, 0),
            child: Column(
              children: [
                Image.asset('assets/images/logologo.png', height: 150),
                const SizedBox(height: 30),

                // Campo de Email
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Campo de Senha
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Botão de Entrar
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainNavigation(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Entrar', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 10),

                // Link para criar conta
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Não tem conta? Crie uma!',
                    style: TextStyle(color: Color(0xFF4A90E2)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Recorte curvo superior com rebaixo central
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 150);
    path.quadraticBezierTo(size.width / 2, 250, size.width, 150);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
