import 'package:ebbie/pages/acessibilidade_page.dart';
import 'package:ebbie/pages/email_page.dart';
import 'package:ebbie/pages/intro_page.dart';
import 'package:ebbie/pages/name_page.dart';
import 'package:ebbie/pages/profile_page.dart';
import 'package:ebbie/pages/revisionExpand.dart';
import 'package:ebbie/pages/revision_page.dart';
import 'package:ebbie/pages/password_page.dart';
import 'package:ebbie/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'widgets/bottom_nav.dart';
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
      home: BottomNav(),
    );
  }
}
