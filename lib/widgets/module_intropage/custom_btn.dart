import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class BtnForm extends StatelessWidget {
  final String title;
  final Color cor;

  const BtnForm({
    super.key,
    required this.title,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size(150, 30)),
        backgroundColor: WidgetStateProperty.all(cor),
        foregroundColor: WidgetStateProperty.all(AppColors.pastelBeige),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () {

      },
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Cerebri Sans',
          fontSize: 15,
        ),
      ),
    );
  }
}
