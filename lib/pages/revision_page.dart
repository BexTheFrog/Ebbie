import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/widgets/custom_appbar_with_comeback.dart';
import 'package:ebbie/widgets/custom_revision_header.dart';
import 'package:ebbie/widgets/revision_card.dart';
import 'package:flutter/material.dart';

class RevisionPage extends StatefulWidget {
  final int subjectId;

  const RevisionPage({super.key, required this.subjectId});

  @override
  State<RevisionPage> createState() => _RevisionPageState();
}

class _RevisionPageState extends State<RevisionPage> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> revisions = [];
  String subjectName = '';

  @override
  void initState() {
    super.initState();
    _loadRevisions();
  }

  Future<void> _loadRevisions() async {
    final data = await dbHelper.query(
      'tarefa',
      where: 'idMateria = ?',
      whereArgs: [widget.subjectId],
    );

    if (data.isNotEmpty) {
      // Pega o nome da matéria
      final materiaData = await dbHelper.query(
        'materia',
        where: 'id = ?',
        whereArgs: [widget.subjectId],
      );
      subjectName = materiaData.isNotEmpty ? materiaData[0]['nome'] ?? '' : '';

      // Calcula quantas revisões faltam para memorizar
      final revisionsWithProgress = data.map((t) {
        int repeticoes = t['repeticoes'] ?? 0;
        int faltam = (5 - repeticoes).clamp(0, 5);
        return {...t, 'faltamMemorizar': faltam};
      }).toList();

      setState(() {
        revisions = revisionsWithProgress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWithComeback(),
      backgroundColor: const Color(0xFFFFF9E9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subjectName.isNotEmpty) GramaticaHeader(title: subjectName),
            const SizedBox(height: 20),
            ...revisions.map((rev) {
              String reviewStatus;
              if (rev['status'] == 'memorizou' || rev['faltamMemorizar'] == 0) {
                reviewStatus = 'Memorizado!';
              } else {
                reviewStatus =
                    '${rev['descricao'] ?? ''} - Faltam ${rev['faltamMemorizar']} revisões para memorizar';
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RevisionCard(
                    titleReview: rev['topico'] ?? 'Sem título',
                    staticReview: reviewStatus,
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
            if (revisions.isEmpty)
              Center(
                child: Text(
                  'Nada ainda por aqui, tente adicionar uma revisão',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.darkSlate,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
