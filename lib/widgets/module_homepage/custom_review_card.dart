import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/module_forms/custom_review_mood.dart';
import 'package:ebbie/widgets/module_profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomReviewCard extends StatefulWidget {
  final String materia;
  final String modulo;
  final String reviewName;
  final String reviewDesc;
  final DateTime dataReview;
  final Function function;
  final Function onPressed;
  final Function hasStudy;
  final bool wasReviewd;
  final bool wasSkipped;

  const CustomReviewCard({
    super.key,
    required this.materia,
    required this.modulo,
    required this.reviewName,
    required this.reviewDesc,
    required this.dataReview,
    required this.function,
    required this.onPressed,
    required this.hasStudy,
    this.wasSkipped = false,
    this.wasReviewd = false,
  });

  @override
  State<CustomReviewCard> createState() => _CustomReviewCardState();
}

class _CustomReviewCardState extends State<CustomReviewCard> {
  
  @override
  Widget build(BuildContext context) 
  {final theme = context.watch<ThemeController>();
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
  late bool wasStudied;

  @override
  void initState() {
    super.initState();
    wasStudied = widget.wasReviewd;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        widget.onPressed();
      },
      onTap: () {
        widget.function();
      },
      child: Stack(
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
                  color: theme.tituloCardReviwColor,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.modulo,
                        style: TextStyle(
                          fontFamily: 'CerebriSansPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.materia,
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
                decoration: BoxDecoration(color: theme.subTituloCardReviwColor),
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
                Container(
                  height: 40,
                  decoration: BoxDecoration(color: AppColors.tealBlue),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.reviewName,
                        style: TextStyle(
                          fontFamily: 'CerebriSansPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(widget.dataReview),
                        style: TextStyle(
                          fontFamily: 'CerebriSansPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
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
                    color: theme.descricaoCardReviwColor,
                    ],
                  ),
                ),

                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F1BB).withAlpha(85),
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.check_box_outline_blank_rounded,
                      color: theme.descricaoCardReviwColor,
                      size: 30,
                    ),
                   
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.reviewDesc,
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
                    children: [
                      GestureDetector(
                        onTap: widget.wasSkipped
                            ? null
                            : () async {
                                final today = DateTime.now();
                                final onlyToday = DateTime(
                                  today.year,
                                  today.month,
                                  today.day,
                                );
                                final taskDate = DateTime(
                                  widget.dataReview.year,
                                  widget.dataReview.month,
                                  widget.dataReview.day,
                                );

                                // Bloqueia se não for o dia da revisão
                                if (onlyToday != taskDate) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomMsgDialog(
                                      title: 'Atenção',
                                      content:
                                          'Você só pode marcar esta revisão no dia da dela.',
                                      ok: CustomOk(
                                        function: () => Navigator.pop(context),
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                // Se for o dia certo, abre o mood
                                final selectedMood = await showDialog<String>(
                                  context: context,
                                  builder: (dialogContext) {
                                    return CustomReviewMood(
                                      title: 'Como foi a revisão?',
                                      onConfirm: (mood) {
                                        Navigator.of(dialogContext).pop(mood);
                                      },
                                    );
                                  },
                                );

                                if (selectedMood != null) {
                                  setState(
                                    () => wasStudied = true,
                                  ); // só marca agora
                                  await widget.hasStudy(selectedMood);
                                }
                              },
                        child: Icon(
                          wasStudied
                              ? Icons.check_box_rounded
                              : Icons.check_box_outline_blank_rounded,
                          color: widget.wasSkipped
                              ? Colors.grey
                              : AppColors.darkSlate,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
