import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class CustomFormFieldTask extends StatefulWidget {
  final String hintText;

  const CustomFormFieldTask({super.key, required this.hintText});

  @override
  State<CustomFormFieldTask> createState() => _CustomFormFieldTaskState();
}

class _CustomFormFieldTaskState extends State<CustomFormFieldTask> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: AppColors.tealBlue),
          filled: true,
          fillColor: AppColors.pastelBeige,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: AppColors.tealBlue, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: AppColors.tealBlue, width: 3),
          ),
        ),
      ),
    );
  }
}
