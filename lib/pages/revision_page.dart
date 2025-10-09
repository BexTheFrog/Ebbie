
import 'package:ebbie/widgets/custom_revision_header.dart';
import 'package:ebbie/widgets/revision_card.dart';
import 'package:ebbie/widgets/revision_page_appbar.dart';
import 'package:flutter/material.dart';

class RevisionPage extends StatelessWidget {
  const RevisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RevisionPageAppbar(),
      backgroundColor: const Color(0xFFFFF9E9),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 20),
            GramaticaHeader(),
            SizedBox(height: 30),
            RevisionCard(
              title: 'Artigos Definidos',
              subtitle: '4 revisões para memorizar...',
            ),
            SizedBox(height: 20),
            RevisionCard(
              title: 'Artigos Indefinidos',
              subtitle: '2 revisões para memorizar...',
            ),
            SizedBox(height: 20),
            RevisionCard(
              title: 'Adjetivos',
              subtitle: 'Memorizou',
            ),
          ],
        ),
      ),
    );
  }
}
