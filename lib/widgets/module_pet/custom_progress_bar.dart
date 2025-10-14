import 'package:ebbie/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CustomProgressBar extends StatefulWidget {
  const CustomProgressBar({
    super.key,
    required this.barTitle,
    required this.barIcon,
    required this.progression,
  });

  final String barTitle;
  final IconData barIcon;
  final double progression;

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pastelYellow,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      height: 40,
      width: 250,
      alignment: Alignment.center,
      child: LinearPercentIndicator(
        width: 250,
        progressColor: AppColors.tealBlue,
        backgroundColor: AppColors.darkSlate.withAlpha(50),
        lineHeight: 25,
        percent: widget.progression,
        barRadius: Radius.circular(60),
        center: Row(
          children: [
            SizedBox(width: 5),
            Icon(widget.barIcon, color: AppColors.pastelYellow, size: 20),
            SizedBox(width: 5),
            Text(
              widget.barTitle,
              style: TextStyle(
                color: AppColors.pastelYellow,
                fontFamily: 'CerebriSansPro',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
