import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectHeader extends StatelessWidget {
  final String title;

  const SubjectHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: theme.cerebroLineColor,
            letterSpacing: 2,
            fontFamily: 'CerebriSansPro',
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            width: 800, // tamanho da linha
            child: Row(
              children: [
                // Linha esquerda
                Expanded(
                  child: Container(
                    height: 5, // Espessura da linha
                    decoration: BoxDecoration(
                      color: theme.cerebroLineColor,
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
                    color: theme.cerebroLineColor,
                  ),
                ),

                // Linha direita
                Expanded(
                  child: Container(
                    height: 5, // Espessura da linha
                    decoration: BoxDecoration(
                      color: theme.cerebroLineColor,
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
