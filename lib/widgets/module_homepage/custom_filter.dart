import 'package:ebbie/config/app_colors.dart';
import 'package:flutter/material.dart';

class FiltroPeriodo extends StatelessWidget {
  final String periodoAtual;
  final Function(String) onPeriodoChanged;
  final List<String> periodos = ["HOJE", "SEMANA", "MÊS"];

  FiltroPeriodo({
    super.key,
    required this.periodoAtual,
    required this.onPeriodoChanged,
  });

  void _mudarPeriodo(String periodo, int direcao) {
    final index = periodos.indexOf(periodo);
    int newIndex = (index + direcao) % periodos.length;
    if (newIndex < 0) newIndex = periodos.length - 1;
    onPeriodoChanged(periodos[newIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _mudarPeriodo(periodoAtual, -1),
          child: Icon(
            Icons.arrow_left_rounded,
            size: 60,
            color: AppColors.darkSlate,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            periodoAtual,
            style: const TextStyle(
              fontFamily: 'CerebriSansPro',
              fontSize: 35,
              color: AppColors.darkSlate,
              height: 1,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _mudarPeriodo(periodoAtual, 1),
          child: Icon(
            Icons.arrow_right_rounded,
            size: 60,
            color: AppColors.darkSlate,
          ),
        ),
      ],
    );
  }
}
