import 'package:flutter/material.dart';
import 'package:ebbie/pages/revision_page.dart';

class CardGridPage extends StatelessWidget {
  const CardGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // 👈 Card Gramática com onTap
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RevisionPage()),
              );
            },
            child: const CustomCard(
              icon: Icons.book,
              label: 'Gramática',
            ),
          ),
          const CustomCard(
            icon: Icons.library_books,
            label: 'Vocabulário',
          ),
          const CustomCard(
            icon: Icons.record_voice_over,
            label: 'Fonética',
          ),
          const CustomCard(
            icon: Icons.add,
            label: 'Adicionar',
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const CustomCard({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFF4F1BB), width: 3),
      ),
      color: const Color(0xFF9BC1BC),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 48,
              color: const Color(0xFFF4F1BB),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF4F1BB),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
