import 'package:ebbie/widgets/module_forms/custom_dialog_add_section.dart';
import 'package:flutter/material.dart';
import 'package:ebbie/pages/revision_page.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
            child: const CustomCard(label: 'Gramática'),
          ),
          const CustomCard(label: 'Vocabulário'),
          const CustomCard(label: 'Fonética'),
          const CustomCardAdd(label: 'Adicionar'),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String label;
  final Function? dialog;

  const CustomCard({super.key, required this.label, this.dialog});

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
        child: GestureDetector(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.bookMarked,
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
                  fontFamily: 'CerebriSansPro',
                ),
              ),
            ],
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return CustomDialogAddSection();
              },
            );
          },
        ),
      ),
    );
  }
}

class CustomCardAdd extends StatelessWidget {
  final String label;
  final Function? dialog;

  const CustomCardAdd({super.key, required this.label, this.dialog});

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
        child: GestureDetector(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.circlePlus,
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
                  fontFamily: 'CerebriSansPro',
                ),
              ),
            ],
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return CustomDialogAddSection();
              },
            );
          },
        ),
      ),
    );
  }
}
