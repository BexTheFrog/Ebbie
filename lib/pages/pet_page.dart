import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/custom_appbar.dart';
import 'package:ebbie/widgets/custom_appbar_with_comeback.dart';
import 'package:ebbie/widgets/module_forms/custom_dialog_add_module.dart';
import 'package:ebbie/widgets/module_pet/custom_progress_bar.dart';
import 'package:ebbie/widgets/module_pet/custom_round_btn.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PetPage extends StatefulWidget {
  const PetPage({super.key});

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithComeback(),
      backgroundColor: const Color(0xFFF7EDE2),
      body: ListView(
        //scrollDirection: Axis.vertical,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Stack(
                children: [
                  Positioned(
                    top: 15,
                    left: 45,
                    child: Column(
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Text(
                              "Cortex",
                              style: TextStyle(
                                color: AppColors.coral,
                                fontFamily: 'CerebriSansPro',
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return CustomDialogAddModule();
                                  },
                                );
                              },
                              child: Icon(
                                LucideIcons.squarePen,
                                color: AppColors.coral,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                spacing: 10,
                                children: [
                                  CustomProgressBar(
                                    barIcon: LucideIcons.brushCleaning,
                                    barTitle: "HIGIENE",
                                    progression: 0.4,
                                  ),
                                  CustomProgressBar(
                                    barIcon: LucideIcons.weight,
                                    barTitle: "FIT",
                                    progression: 0.6,
                                  ),
                                  CustomProgressBar(
                                    barIcon: LucideIcons.cookie,
                                    barTitle: "FOME",
                                    progression: 0.7,
                                  ),
                                ],
                              ),
                            ),
                            // Column(
                            //   spacing: 10,
                            //   children: [
                            //     //CustomRoundBtn(btnIcon: LucideIcons.store),
                            //     CustomRoundBtn(btnIcon: LucideIcons.volume2),
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 600,
                    width: 350,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.coral.withAlpha(25),
                      borderRadius: BorderRadiusGeometry.circular(60),
                    ),
                    child: Positioned(
                      child: Image.asset(
                        'assets/images/cortex/cortex_idle.gif',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 20,
                    child: Container(
                      width: 300,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.pastelYellow.withAlpha(150),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        spacing: 30,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomRoundBtn(btnIcon: LucideIcons.brushCleaning),
                          CustomRoundBtn(btnIcon: LucideIcons.dumbbell),
                          CustomRoundBtn(btnIcon: LucideIcons.cookie),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
