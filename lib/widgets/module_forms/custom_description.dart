import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDescription extends StatefulWidget {
  final TextEditingController controller;

  const CustomDescription({super.key, required this.controller});

  @override
  State<CustomDescription> createState() => _CustomDescriptionState();
}

class _CustomDescriptionState extends State<CustomDescription> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();

    return TextField(
      controller: widget.controller,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Descrição...',
        hintStyle: TextStyle(
          color: theme.formReviewColor,
          fontFamily: 'CerebriSansPro',
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: AppColors.pastelBeige,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: theme.formReviewColor, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: theme.formReviewColor, width: 3),
        ),
      ),
    );
  }
}
