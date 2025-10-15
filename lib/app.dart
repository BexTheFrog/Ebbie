import 'package:ebbie/pages/accessibility_page.dart';
import 'package:ebbie/pages/bottom_nav.dart';
import 'package:ebbie/pages/intro_page.dart';
import 'package:ebbie/pages/pet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Ebbie extends StatelessWidget {
  const Ebbie({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: AccessibilityPage(),
    );
  }
}
