import 'package:ebbie/config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomReviewCard extends StatefulWidget {
  const CustomReviewCard({super.key});

  // final String Materia;
  // final String Topico;
  // final String Review_Name;
  // final String Review_Desc;
  // final DateTime dataReview;

  @override
  State<CustomReviewCard> createState() => _CustomReviewCardState();
}

class _CustomReviewCardState extends State<CustomReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 225,
          width: 400,
          decoration: BoxDecoration(
            color: Color(0xFFF7EDE2),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(5, 5),
              ),
            ],
          ),
        ),

        Container(
          width: 400,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: AppColors.coral,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "TÓPICO",
                      style: TextStyle(
                        fontFamily: 'CerebriSansPro',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "MATÉRIA",
                      style: TextStyle(
                        fontFamily: 'CerebriSansPro',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 40,
                decoration: BoxDecoration(color: AppColors.tealBlue),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "REVIEW",
                      style: TextStyle(
                        fontFamily: 'CerebriSansPro',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "DATA",
                      style: TextStyle(
                        fontFamily: 'CerebriSansPro',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F1BB).withAlpha(85),
                ),
                padding: const EdgeInsets.all(10),
                alignment: Alignment.topLeft,
                child: Text(
                  "Descrição Review",
                  style: TextStyle(
                    fontFamily: 'CerebriSansPro',
                    fontSize: 16,
                    color: const Color(0xFF78624D).withAlpha(200),
                  ),
                ),
              ),

              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F1BB).withAlpha(85),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.check_box_outline_blank_rounded,
                      color: AppColors.darkSlate,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_circle_right_rounded,
                      color: AppColors.darkSlate,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
