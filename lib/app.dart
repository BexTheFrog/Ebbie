import 'package:ebbie/pages/accessibility_page.dart';
import 'package:ebbie/pages/bottom_nav.dart';
import 'package:ebbie/pages/pet_page.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class Ebbie extends StatelessWidget {
  const Ebbie({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ebbie',
          locale: const Locale('pt', 'BR'),
          supportedLocales: const [Locale('pt', 'BR')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: themeController.primaryColor,
            ),
            scaffoldBackgroundColor: const Color(0xFFFDF7E4),
            appBarTheme: AppBarTheme(
              backgroundColor: themeController.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
          home: const BottomNav(),
          // ou:
          // home: const AccessibilityPage(),
        );
      },
    );
  }
}
