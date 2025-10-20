import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_description.dart';
import 'package:ebbie/widgets/module_forms/custom_form_task.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class CustomDialogAddModule extends StatefulWidget {
  final Map<String, dynamic>? module;

  const CustomDialogAddModule({super.key, this.module});

  @override
  State<CustomDialogAddModule> createState() => _CustomDialogAddModuleState();
}

class _CustomDialogAddModuleState extends State<CustomDialogAddModule> {
  
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.module != null) {
      _nomeController.text = widget.module!['nome'] ?? '';
      _descricaoController.text = widget.module!['descricao'] ?? '';
    }
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
              color: theme.formReviewColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.module == null ? 'Novo módulo' : 'Editando módulo',
                    style: const TextStyle(
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
                  hintText: "Nome do módulo...",
                  controller: _nomeController,
                ),
                const SizedBox(height: 12),
                CustomDescription(controller: _descricaoController),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomOk(
                    function: () async {
                      final nome = _nomeController.text.trim();
                      final descricao = _descricaoController.text.trim();

                      if (nome.isEmpty || descricao.isEmpty) {
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

                      Navigator.pop(context, {
                        'nome': nome,
                        'descricao': descricao,
                      });
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
