import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class LabelsForm extends StatelessWidget {
  final String title;

  const LabelsForm({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Cerebri Sans',
        fontSize: 20,
        color: AppColors.pastelBeige,
         // sua cor definida no app_colors.dart
      ),
    );
  }
}
