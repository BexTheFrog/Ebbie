import 'package:ebbie/pages/homepage.dart';
import 'package:flutter/material.dart';

class Ebbie extends StatelessWidget {
  const Ebbie({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

