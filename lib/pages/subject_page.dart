import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_subject_header.dart';
import 'package:ebbie/widgets/card_grid_subject.dart';

class SubjectPage extends StatelessWidget {
  const SubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(coinCount: 15),
      backgroundColor: const Color(0xFFFFF9E9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SubjectHeader(),
            SizedBox(height: 20),
            CardGridPage(),
          ],
        ),
      ),
    );
  }
}
