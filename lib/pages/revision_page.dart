import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/widgets/custom_appbar_with_comeback.dart';
import 'package:ebbie/widgets/custom_revision_header.dart';
import 'package:ebbie/widgets/revision_card.dart';
import 'package:flutter/material.dart';

class RevisionPage extends StatefulWidget {
  final int subjectId; // ID da matéria

  const RevisionPage({super.key, required this.subjectId});

  @override
  State<RevisionPage> createState() => _RevisionPageState();
}

class _RevisionPageState extends State<RevisionPage> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> revisions = [];

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
    setState(() {
      revisions = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWithComeback(),
      backgroundColor: const Color(0xFFFFF9E9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ...revisions.map((rev) {
              GramaticaHeader(
                title: rev['titulo'] ?? 'Erro ao carregar titulo',
              );
              const SizedBox(height: 30);
              return Column(
                children: [
                  RevisionCard(
                    titleReview: rev['titulo'] ?? 'Sem título',
                    staticReview: rev['status'] == 'memorizou'
                        ? 'Memorizou'
                        : '${rev['quantidade']} revisões para memorizar...',
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
            if (revisions.isEmpty)
              Column(
                children: [
                  Text(
                    'Nada ainda por aqui, tente adicionar uma revisão',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.darkSlate,
                      fontFamily: 'CerebriSansPro',
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
