import 'package:flutter/material.dart';

class GramaticaHeader extends StatelessWidget {
  const GramaticaHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'GRAMÁTICA',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5E4B6E),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: SizedBox(
            width: 800, // tamanho da linha
            child: Row(
              children: [
                // Linha esquerda
                Expanded(
                  child: Container(
                    height: 5, // Espessura da linha
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8B2B2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Ícone no centro
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Image.asset(
                    "assets/images/brain_icon_small.png",
                    height: 50,
                    color: const Color(0xFFB8B2B2),
                  ),
                ),

                // Linha direita
                Expanded(
                  child: Container(
                    height: 5, // Espessura da linha
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8B2B2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
