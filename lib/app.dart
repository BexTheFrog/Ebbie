import 'package:ebbie/pages/homepage.dart';
import 'package:flutter/material.dart';

class Ebbie extends StatelessWidget {
  const Ebbie({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

