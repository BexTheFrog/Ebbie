import 'package:ebbie/widgets/accessibility_appar.dart';
import 'package:flutter/material.dart';
// importa o seu Custom AppBar

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccessibilityAppar(), // usa o AppBar que você criou
      backgroundColor: const Color(0xFFF7EDE2), // cor de fundo suave
      body: const Center(
        child: Text(
          'Página de Acessibilidade',
          style: TextStyle(
            color: Color(0xFF5D576C),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
