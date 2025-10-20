import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/custom_appbar_with_comeback.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Revisionexpand extends StatefulWidget {
  final String titulo;
  final String modulo;
  final String secao;
  final String descricao;
  final DateTime dataReview;

  const Revisionexpand({
    super.key,
    required this.titulo,
    required this.modulo,
    required this.secao,
    required this.descricao,
    required this.dataReview,
  });

  @override
  State<Revisionexpand> createState() => _RevisionexpandState();
}

class _RevisionexpandState extends State<Revisionexpand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE2),
      appBar: CustomAppBarWithComeback(),
      body: Center(
        child: Container(
          height: 700,
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              spacing: 20,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.titulo.toUpperCase(),
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'CerebriSansPro',
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkSlate,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(widget.dataReview),
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CerebriSansPro',
                        fontWeight: FontWeight.bold,
                        color: AppColors.coral,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.modulo.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CerebriSansPro',
                        fontWeight: FontWeight.bold,
                        color: AppColors.yellowPicked,
                      ),
                    ),
                    Text(
                      widget.secao.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CerebriSansPro',
                        fontWeight: FontWeight.bold,
                        color: AppColors.yellowPicked,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    widget.descricao,
                    style: TextStyle(
                      fontFamily: 'CerebriSansPro',
                      fontSize: 14,
                      color: AppColors.darkSlate,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
