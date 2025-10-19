import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/module_forms/custom_description.dart';
import 'package:ebbie/widgets/module_forms/custom_form_task.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class CustomDialogAddModule extends StatefulWidget {
  const CustomDialogAddModule({super.key});

  @override
  State<CustomDialogAddModule> createState() => _CustomDialogAddModuleState();
}

class _CustomDialogAddModuleState extends State<CustomDialogAddModule> {
  
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return Dialog(
      backgroundColor: const Color(0xFFF7EDE2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cabeçalho com título e botão fechar
          Container(
            decoration: BoxDecoration(
              color: theme.formReviewColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 10,
                right: 10,
                bottom: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Novo módulo',
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ], // <-- fecha o children do Row
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                CustomFormFieldTask(hintText: "Descrição..."),
                const SizedBox(height: 12),
                CustomDescription(),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomOk(
                    function: () {
                      Navigator.pop(context);
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
