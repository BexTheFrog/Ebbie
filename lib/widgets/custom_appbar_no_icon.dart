import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class CustomAppbarNoIcon extends StatelessWidget
    implements PreferredSizeWidget {
  final int coinCount;
  final String segment;

  const CustomAppbarNoIcon({
    super.key,
    this.coinCount = 0,
    required this.segment,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.appbarColor,
        flexibleSpace: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              //BOTAO VOLTAR
              Positioned(
                left: 25,
                child: IconButton(
                  icon: const Icon(
                    LucideIcons.squareArrowLeft,
                    color: Color(0xFFF4F1BB),
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero, // centraliza o ícone
                  iconSize: 24,
                ),
              ),

              //TITULO CENTRAL
              Positioned(
                right: 30,
                child: Text(
                  segment,
                  style: TextStyle(
                    color: Color(0xFFF4F1BB),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
