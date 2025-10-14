import 'package:ebbie/config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDescription extends StatefulWidget {
  const CustomDescription({super.key});

  @override
  State<CustomDescription> createState() => _CustomDescriptionState();
}

class _CustomDescriptionState extends State<CustomDescription> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Descrição...',
        hintStyle: const TextStyle(
          color: AppColors.tealBlue,
          fontFamily: 'CerebriSansPro',
          fontWeight: FontWeight.bold,
        ),
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
    );
  }
}
