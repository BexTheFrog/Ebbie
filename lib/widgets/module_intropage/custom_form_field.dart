import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

 
class CustomFormField extends StatelessWidget {
  final String hintText;
  final bool state;

 
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.state,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                      width: 350,
                      child: TextFormField(
                        obscureText: state,
                        decoration: InputDecoration(
                          hintText: hintText,
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(158, 157, 157, 1)
                          ), // Fica fixo como placeholder
                          filled: true,
                          fillColor: AppColors.pastelBeige, // evita flutuar
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              color: AppColors.tealBlue,
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              color: AppColors.tealBlue,
                              width: 3,
                            ),
                          ),
                        ),
                      ),

    );
  }
}