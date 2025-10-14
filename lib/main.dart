import 'package:ebbie/app.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  await initializeDateFormatting('pt_BR', null);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: const EbbieRoot(),
    ),
  );
}

class EbbieRoot extends StatelessWidget {
  const EbbieRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ebbie',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: themeController.primaryColor,
            ),
            scaffoldBackgroundColor: const Color(0xFFFDF7E4),
          ),
          home: const Ebbie(),
        );
      },
    );
  }
}
