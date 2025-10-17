import 'package:ebbie/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomMsgDialog extends StatefulWidget {
  final String title;
  final String content;
  final Widget ok;

  const CustomMsgDialog({
    super.key,
    required this.title,
    required this.content,
    required this.ok,
  });

  @override
  State<CustomMsgDialog> createState() => _CustomMsgDialogState();
}

class _CustomMsgDialogState extends State<CustomMsgDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF7EDE2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cabeçalho com título e botão fechar
          Container(
            decoration: BoxDecoration(
              color: AppColors.tealBlue,
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
                  Text(
                    widget.title,
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
                const SizedBox(height: 10),
                Text(
                  widget.content,
                  style: TextStyle(
                    fontFamily: 'CerebriSansPro',
                    color: AppColors.tealBlue,
                  ),
                ),
                const SizedBox(height: 10),
                Align(alignment: Alignment.centerRight, child: widget.ok),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
