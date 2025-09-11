import 'package:flutter/material.dart';

class RevisionPage extends StatelessWidget {
  const RevisionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF5D576B),
          flexibleSpace: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Logo no centro
                Image.asset('assets/images/logo.png', height: 50),
                // Pontuação no canto superior direito
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(247, 237, 226, 1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFFE9A751), // cor da borda
                        width: 2, // espessura da borda
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          '15',
                          style: TextStyle(
                            color: Color.fromRGBO(233, 167, 81, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 3),
                        Icon(
                          Icons.paid,
                          color: Color.fromRGBO(233, 167, 81, 1),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
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
            
            // Container para a linha com ícone no centro
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
            
            const SizedBox(height: 30),
            // Card de Artigos Definidos
            _buildTopicCard(
              title: 'Artigos definidos',
              subtitle: '4 revisões para memorizar...',
              statisticsButtonBorderColor: const Color(0xFFF4F1BB),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // --- Funções auxiliares ---
  Widget _buildTopicCard({
    required String title,
    required String subtitle,
    Color? statisticsButtonBorderColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF5D576B),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bookmark, color: Color(0xFFF4F1BB)),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCardButton(
                  text: 'Revisões',
                  icon: Icons.description_outlined,
                  borderColor: const Color(0xFFF4F1BB),
                ),
                _buildCardButton(
                  text: 'Estatísticas',
                  icon: Icons.data_usage,
                  borderColor: statisticsButtonBorderColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardButton({
    required String text,
    required IconData icon,
    Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF9BC1BC),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: borderColor ?? Colors.transparent, width: 2),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}