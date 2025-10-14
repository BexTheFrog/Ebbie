import 'package:ebbie/widgets/custom_appbar_no_icon.dart';
import 'package:flutter/material.dart';

class CheatPage extends StatelessWidget {
  const CheatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarNoIcon(
        segment: "CheatMenu",
      ), // usa o AppBar customizado
      backgroundColor: const Color(0xFFF7EDE2), // cor de fundo suave
      body: const Center(
        child: Text(
          'Página de Cheat Menu',
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
