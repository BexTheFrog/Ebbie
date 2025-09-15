import 'package:ebbie/pages/intro_page.dart';
import 'package:ebbie/pages/revision_page.dart';
import 'package:ebbie/pages/search_page.dart';
import 'package:ebbie/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:ebbie/pages/homepage.dart';
import 'package:ebbie/pages/pomodoro_page.dart';
import 'package:ebbie/pages/profile_page.dart';
import 'package:ebbie/pages/subject_page.dart';

import 'widgets/bottom_nav.dart';

class Ebbie extends StatelessWidget {
  const Ebbie({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ebbie',
      // home: BottomNav(),
      home: IntroPage(),

    );
  }
}
