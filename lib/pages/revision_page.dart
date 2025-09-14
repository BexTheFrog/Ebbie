import 'package:ebbie/widgets/custom_appbar.dart';
import 'package:ebbie/widgets/custom_revision_header.dart';
import 'package:flutter/material.dart';


class RevisionPage extends StatelessWidget {
  const RevisionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(coinCount: 15),
      backgroundColor: const Color(0xFFF7EDE2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            GramaticaHeader(),

            
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