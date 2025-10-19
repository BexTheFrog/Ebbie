import 'package:ebbie/services/database.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_dialog_add_section.dart';
import 'package:ebbie/pages/revision_page.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CardGridPage extends StatefulWidget {
  final int moduleId;
  final int userId;

  const CardGridPage({super.key, required this.moduleId, required this.userId});

  @override
  State<CardGridPage> createState() => _CardGridPageState();
}

class _CardGridPageState extends State<CardGridPage> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> subjects = [];

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    final data = await dbHelper.query(
      'materia',
      where: 'moduloId = ? AND idUsuario = ?',
      whereArgs: [widget.moduleId, widget.userId],
    );
    setState(() {
      subjects = data;
    });
  }

  Future<void> _addSubject() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => const CustomDialogAddSection(),
    );

    if (result != null) {
      await dbHelper.insert('materia', {
        'nome': result['nome'],
        'moduloId': widget.moduleId,
        'idUsuario': widget.userId,
      });

      _loadSubjects();
    }
  }

  Future<void> _removeSubject(int subjectId) async {
    // Mostra o diálogo de confirmação
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomMsgDialog(
          title: 'Excluir matéria?',
          content: 'Deseja realmente excluir esta matéria?',
          ok: CustomOk(function: () => Navigator.pop(dialogContext, true)),
        );
      },
    );

    if (confirm == true) {
      await dbHelper.delete('materia', 'id = ?', [subjectId]);
      setState(() {
        _loadSubjects();
      });
    }
  }

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
          ...subjects.map((subject) {
            return CustomCard(
              label: subject['nome'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RevisionPage(subjectId: subject['id']),
                  ),
                );
              },
              onLongPress: () => _removeSubject(subject['id']),
            );
          }).toList(),
          CustomCardAdd(label: 'Adicionar', onTap: _addSubject),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String label;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.label,
    this.onTap,
    this.onLongPress,
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
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
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
                  textAlign: TextAlign.center,
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF4F1BB),
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCardAdd extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const CustomCardAdd({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFF4F1BB), width: 3),
      ),
      color: const Color(0xFF9BC1BC),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Center(
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
        ),
      ),
    );
  }
}
