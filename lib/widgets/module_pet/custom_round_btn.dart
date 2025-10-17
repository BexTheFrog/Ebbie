import 'package:ebbie/config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomRoundBtn extends StatefulWidget {
  const CustomRoundBtn({super.key, required this.btnIcon});

  final IconData btnIcon;

  @override
  State<CustomRoundBtn> createState() => _CustomRoundBtnState();
}

class _CustomRoundBtnState extends State<CustomRoundBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(color: AppColors.pastelYellow, width: 3),
        ),
        backgroundColor: AppColors.tealBlue,
        fixedSize: Size(60, 60),
        iconSize: 30,
        padding: EdgeInsets.all(8),
      ),
      child: Icon(widget.btnIcon, color: AppColors.pastelYellow),
    );
  }
}
