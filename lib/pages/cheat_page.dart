import 'package:ebbie/widgets/cheat_appbar.dart';
import 'package:flutter/material.dart';


class CheatPage extends StatelessWidget {
  const CheatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheatAppbar(), // usa o AppBar customizado
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
