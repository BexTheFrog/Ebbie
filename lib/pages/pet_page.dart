import 'dart:async';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_edit_cortex_name.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/widgets/custom_appbar_with_comeback.dart';
import 'package:ebbie/widgets/module_pet/custom_progress_bar.dart';
import 'package:ebbie/widgets/module_pet/custom_round_btn.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../services/wallet.dart';

class PetPage extends StatefulWidget {
  const PetPage({super.key});

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  final dbHelper = DatabaseHelper();
  final TextEditingController nameController = TextEditingController();
  int? userId;

  String nome = 'CortexTeste';
  double fome = 0.5;
  double fit = 0.5;
  double higiene = 0.5;

  String idleGif = 'assets/images/cortex/cortex_idle.gif';
  String currentGif = 'assets/images/cortex/cortex_idle.gif';

  @override
  void initState() {
    super.initState();
    _loadUserAndPet();
  }

  Future<void> _loadUserAndPet() async {
    userId = await UserService.getUserId();

    if (userId != null) {
      final userData = await dbHelper.query(
        'user',
        where: 'id = ?',
        whereArgs: [userId],
      );
      if (userData.isNotEmpty)
        coinNotifier.value = userData.first['carteira'] ?? 0;

      final petData = await dbHelper.query(
        'cortex',
        where: 'idUsuario = ?',
        whereArgs: [userId],
      );
      if (petData.isNotEmpty) {
        final pet = petData.first;
        setState(() {
          nome = (pet['nome'] ?? 'noName');
          fome = (pet['fome'] ?? 0.5).toDouble();
          fit = (pet['fit'] ?? 0.5).toDouble();
          higiene = (pet['higiene'] ?? 0.5).toDouble();
        });
      } else {
        await dbHelper.insert('cortex', {
          'idUsuario': userId,
          'nome': nome,
          'fome': fome,
          'fit': fit,
          'higiene': higiene,
        });
      }
    }
  }

  void performAction(
    Function action, {
    int cost = 1,
    required String gifPath,
  }) async {
    if (coinNotifier.value >= cost) {
      coinNotifier.value -= cost;
      action();

      setState(() => currentGif = gifPath);

      if (userId != null) {
        await dbHelper.update(
          'user',
          {'carteira': coinNotifier.value},
          'id = ?',
          [userId],
        );
        await dbHelper.update(
          'cortex',
          {'fome': fome, 'fit': fit, 'higiene': higiene},
          'idUsuario = ?',
          [userId],
        );
      }

      Timer(const Duration(milliseconds: 1500), () {
        if (mounted) setState(() => currentGif = idleGif);
      });
    } else {
      showDialog(
        context: context,
        builder: (showDialogContext) => CustomMsgDialog(
          title: "Moedas insuficientes",
          content: "Você não tem moedas suficientes...",
          ok: CustomOk(
            function: () {
              Navigator.pop(showDialogContext);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return Scaffold(
      appBar: const CustomAppBarWithComeback(),
      backgroundColor: const Color(0xFFF7EDE2),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.fundPetColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          spacing: 15,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final result = await showDialog<String>(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return CustomEditCortexName(
                                      controller: nameController,
                                    );
                                  },
                                );

                                if (result != null && result.isNotEmpty) {
                                  await dbHelper.update(
                                    'cortex',
                                    {'nome': result},
                                    'idUsuario = ?',
                                    [userId],
                                  );

                                  setState(() => nome = result);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    nome,
                                    style: TextStyle(
                                      color: AppColors.coral,
                                      fontFamily: 'CerebriSansPro',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36,
                                    ),
                                  ),
                                  Icon(
                                    LucideIcons.squarePen,
                                    color: AppColors.coral,
                                  ),
                                ],
                              ),
                            ),
                            CustomProgressBar(
                              barIcon: LucideIcons.brushCleaning,
                              barTitle: "HIGIENE",
                              progression: higiene,
                            ),
                            CustomProgressBar(
                              barIcon: LucideIcons.weight,
                              barTitle: "FIT",
                              progression: fit,
                            ),
                            CustomProgressBar(
                              barIcon: LucideIcons.cookie,
                              barTitle: "FOME",
                              progression: fome,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 350,
                      width: 350,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Image.asset(currentGif, fit: BoxFit.contain),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: AppColors.pastelYellow.withAlpha(150),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomRoundBtn(
                                btnIcon: LucideIcons.brushCleaning,
                                onTap: () => performAction(
                                  () =>
                                      higiene = (higiene + 0.1).clamp(0.0, 1.0),
                                  gifPath:
                                      'assets/images/cortex/cortex_shower.gif',
                                ),
                              ),
                              const SizedBox(width: 20),
                              CustomRoundBtn(
                                btnIcon: LucideIcons.dumbbell,
                                onTap: () => performAction(
                                  () => fit = (fit + 0.1).clamp(0.0, 1.0),
                                  gifPath:
                                      'assets/images/cortex/cortex_workout.gif',
                                ),
                              ),
                              const SizedBox(width: 20),
                              CustomRoundBtn(
                                btnIcon: LucideIcons.cookie,
                                onTap: () => performAction(
                                  () => fome = (fome + 0.1).clamp(0.0, 1.0),
                                  gifPath:
                                      'assets/images/cortex/cortex_eating.gif',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
