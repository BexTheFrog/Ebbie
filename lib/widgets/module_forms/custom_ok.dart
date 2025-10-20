import 'package:ebbie/config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomOk extends StatefulWidget {
  final Function function;

  const CustomOk({super.key, required this.function});

  @override
  State<CustomOk> createState() => _CustomOkState();
}

class _CustomOkState extends State<CustomOk> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        widget.function();
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: const BorderSide(color: AppColors.tealBlue, width: 4),
      ),
      child: const Text(
        'Ok',
        style: TextStyle(
          fontFamily: 'CerebriSansPro',
          fontWeight: FontWeight.bold,
          color: AppColors.tealBlue,
          fontSize: 15,
        ),
      ),
    );
  }
}
