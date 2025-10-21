import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomOk extends StatefulWidget {
  final Function function;

  const CustomOk({super.key, required this.function});

  @override
  State<CustomOk> createState() => _CustomOkState();
}

class _CustomOkState extends State<CustomOk> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return OutlinedButton(
      onPressed: () {
        widget.function();
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(color: theme.overlayColor, width: 4),
      ),
      child: Text(
        'Ok',
        style: TextStyle(
          fontFamily: 'CerebriSansPro',
          fontWeight: FontWeight.bold,
          color: theme.overlayColor,
          fontSize: 15,
        ),
      ),
    );
  }
}
