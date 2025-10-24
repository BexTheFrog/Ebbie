import 'package:ebbie/services/database.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_dialog_add_section.dart';
import 'package:ebbie/pages/revision_page.dart';
import 'package:ebbie/widgets/module_forms/custom_edit_section.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

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
      _loadSubjects();
    }
  }

  Future<void> _editSubject(Map<String, dynamic> subject) async {
    final updated = await showDialog<bool>(
      context: context,
      builder: (_) => CustomDialogEditSection(
        nomeAtual: subject['nome'],
        idSubject: subject['id'],
      ),
    );

    if (updated == true) {
      _loadSubjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
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
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(
                            LucideIcons.squarePen,
                            color: theme.editarBtnColor,
                          ),
                          title: Text(
                            'Editar',
                            style: TextStyle(
                              fontFamily: 'CerebriSansPro',
                              color: theme.editarBtnColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _editSubject(subject);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            LucideIcons.circleX,
                            color: theme.excluirBtnColor,
                          ),
                          title: Text(
                            'Excluir',
                            style: TextStyle(
                              fontFamily: 'CerebriSansPro',
                              color: theme.excluirBtnColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                            await _removeSubject(subject['id']);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          }),
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
    final theme = context.watch<ThemeController>();
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFF4F1BB), width: 3),
      ),
      color: theme.addCardModuloColor,
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
    final theme = context.watch<ThemeController>();
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFF4F1BB), width: 3),
      ),
      color: theme.addCardModuloColor,
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
