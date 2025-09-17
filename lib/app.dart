import 'package:ebbie/pages/revision_page.dart';
import 'package:ebbie/pages/teste_page.dart';
import 'package:flutter/material.dart';

import 'widgets/bottom_nav.dart';

class Ebbie extends StatelessWidget {
  const Ebbie({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ebbie',
      // home: BottomNav(),
      home: TestePage(),
    );
  }
}
