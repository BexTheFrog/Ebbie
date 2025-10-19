import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_form_task.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/module_profile.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomDialogEditSection extends StatefulWidget {
  final int idSubject;
  final String nomeAtual;

  const CustomDialogEditSection({
    super.key,
    required this.nomeAtual,
    required this.idSubject,
  });

  @override
  State<CustomDialogEditSection> createState() =>
      _CustomDialogEditSectionState();
}

class _CustomDialogEditSectionState extends State<CustomDialogEditSection> {
  late TextEditingController _sectionController;

  @override
  void initState() {
    super.initState();
    _sectionController = TextEditingController(text: widget.nomeAtual);
  }

  @override
  void dispose() {
    _sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF7EDE2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cabeçalho
          Container(
            decoration: BoxDecoration(
              color: AppColors.tealBlue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Editar matéria',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'CerebriSansPro',
                      fontWeight: FontWeight.bold,
                      color: AppColors.pastelYellow,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      LucideIcons.squareX,
                      color: AppColors.pastelYellow,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                CustomFormFieldTask(
                  hintText: "Nome da matéria...",
                  controller: _sectionController,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomOk(
                    function: () async {
                      final nome = _sectionController.text.trim();
                      if (nome.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (_) => CustomMsgDialog(
                            title: "Campo Vazio",
                            content: 'Por favor preencha todos os campos',
                            ok: CustomOk(
                              function: () => Navigator.pop(context),
                            ),
                          ),
                        );
                        return;
                      }

                      // Atualiza o banco aqui
                      await dbHelper.update(
                        'materia',
                        {'nome': nome},
                        'id = ?',
                        [widget.idSubject],
                      );

                      Navigator.pop(context, true); // retorna bool
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
