import 'package:flutter/material.dart';

class RevisionCard extends StatelessWidget {
  final String titleReview;
  final String staticReview;

  const RevisionCard({
    super.key,
    required this.titleReview,
    required this.staticReview,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF5D576B),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bookmark, color: Color(0xFFF4F1BB)),
                const SizedBox(width: 10),
                Text(
                  titleReview,
                  style: const TextStyle(
                    fontFamily: 'CerebriSansPro',
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              staticReview,
              style: TextStyle(
                fontFamily: 'CerebriSansPro',
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
