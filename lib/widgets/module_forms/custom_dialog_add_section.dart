import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_form_task.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class CustomDialogAddSection extends StatefulWidget {
  const CustomDialogAddSection({super.key});

  @override
  State<CustomDialogAddSection> createState() => _CustomDialogAddSectionState();
}

class _CustomDialogAddSectionState extends State<CustomDialogAddSection> {
  final TextEditingController _sectionController = TextEditingController();

  @override
  void dispose() {
    _sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return Dialog(
      backgroundColor: const Color(0xFFF7EDE2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cabeçalho
          Container(
            decoration: BoxDecoration(
              color: theme.overlayColor,
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
                    'Nova matéria',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'CerebriSansPro',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF7EDE2),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      LucideIcons.squareX,
                      color: Color(0xFFF7EDE2),
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                        await showDialog(
                          context: context,
                          builder: (_) => CustomMsgDialog(
                            title: "Campo Vazio",
                            content:
                                'Por favor preencha todos os campos para adicionar',
                            ok: CustomOk(
                              function: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                        return;
                      }
                      Navigator.pop(context, {'nome': nome});
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
