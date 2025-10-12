import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/custom_appbar_with_comeback.dart';
import 'package:flutter/material.dart';

class Revisionexpand extends StatefulWidget {
  const Revisionexpand({super.key});

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
                      "TITULO REVIEW".toUpperCase(),
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'CerebriSansPro',
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkSlate,
                      ),
                    ),
                    Text(
                      "DataReview".toUpperCase(),
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
                      "MÓDULO".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CerebriSansPro',
                        fontWeight: FontWeight.bold,
                        color: AppColors.yellowPicked,
                      ),
                    ),
                    Text(
                      "SEÇÃO".toUpperCase(),
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
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus a facilisis tortor, ut venenatis orci. Morbi pellentesque arcu quis imperdiet facilisis. Phasellus placerat purus ut nulla ullamcorper scelerisque. Sed tincidunt tortor eu efficitur luctus. Duis eu nunc a nisi tristique aliquet ac id erat. Aliquam sapien ex, porttitor ac egestas nec, tristique pulvinar mauris. Sed ultrices nibh ut laoreet tristique. Integer malesuada eros sem, sed suscipit quam dignissim commodo. Morbi viverra eu lacus et aliquam. Nunc sodales ex eu lacus porta, non congue leo aliquam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus a facilisis tortor, ut venenatis orci. Morbi pellentesque arcu quis imperdiet facilisis. Phasellus placerat purus ut nulla ullamcorper scelerisque. Sed tincidunt tortor eu efficitur luctus. Duis eu nunc a nisi tristique aliquet ac id erat. Aliquam sapien ex, porttitor ac egestas nec, tristique pulvinar mauris. Sed ultrices nibh ut laoreet tristique. Integer malesuada eros sem, sed suscipit quam dignissim commodo. Morbi viverra eu lacus et aliquam. Nunc sodales ex eu lacus porta, non congue leo aliquam",
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
