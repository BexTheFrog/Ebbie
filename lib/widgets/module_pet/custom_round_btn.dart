import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomRoundBtn extends StatefulWidget {
  const CustomRoundBtn({super.key, required this.btnIcon, required this.onTap});

  final IconData btnIcon;
  final VoidCallback onTap;

  @override
  State<CustomRoundBtn> createState() => _CustomRoundBtnState();
}

class _CustomRoundBtnState extends State<CustomRoundBtn> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(color: AppColors.pastelYellow, width: 3),
        ),
        backgroundColor: theme.layoutPetColor,
        fixedSize: Size(60, 60),
        iconSize: 30,
        padding: EdgeInsets.all(8),
      ),
      child: Icon(widget.btnIcon, color: AppColors.pastelYellow),
    );
  }
}
