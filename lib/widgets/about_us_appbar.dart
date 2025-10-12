import 'package:flutter/material.dart';

class AboutUsAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int coinCount;

  const AboutUsAppbar({super.key, this.coinCount = 0});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(93, 87, 108, 1),
        flexibleSpace: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              //BOTAO VOLTAR
              Positioned(
                left: 32,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0x3bf5d576b), // fundo leve
                    borderRadius: BorderRadius.circular(8), // arredondamento
                    border: Border.all(
                      color: const Color(0xFFF4F1BB),
                      width: 3,
                    ), // borda
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFF4F1BB),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero, // centraliza o ícone
                    iconSize: 24,
                  ),
                ),
              ),

              //TITULO CENTRAL
              const Center(
                child: Text(
                  'SOBRE NÓS',
                  style: TextStyle(
                    color: Color(0xFFF4F1BB),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
