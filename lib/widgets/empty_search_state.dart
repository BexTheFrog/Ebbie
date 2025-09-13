import 'package:flutter/material.dart';

class EmptySearchState extends StatelessWidget {
  const EmptySearchState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Image.asset(
            'assets/images/oculos.png',
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 3),
          Text(
            'Buscando uma revisão específica?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
