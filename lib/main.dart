import 'package:ebbie/app.dart';
import 'package:ebbie/pages/pomodoro_page.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp();

  // Inicializa formatação de datas
  await initializeDateFormatting('pt_BR', null);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: const Ebbie(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, theme, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: theme.primaryColor),
          ),
          home: const PomodoroPage(),
        );
      },
    );
  }
}
