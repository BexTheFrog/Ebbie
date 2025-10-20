import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_colors.dart';

class CustomFormFieldTask extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomFormFieldTask({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<CustomFormFieldTask> createState() => _CustomFormFieldTaskState();
}

class _CustomFormFieldTaskState extends State<CustomFormFieldTask> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return SizedBox(
      width: 350,
      child: TextFormField(
        maxLength: 15,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
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
        buildCounter:
            (
              BuildContext context, {
              int? currentLength,
              int? maxLength,
              bool? isFocused,
            }) {
              return Text(
                "${maxLength! - currentLength!} caracteres restantes",
                style: TextStyle(
                  color: AppColors.tealBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
      ),
    );
  }
}
