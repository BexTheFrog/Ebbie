import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_colors.dart';

class CustomFormField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType tipoTeclado;

  const CustomFormField({
    super.key,
    required this.hintText,
    required this.isPassword,
    required this.controller,
    required this.tipoTeclado,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return SizedBox(
      width: 350,
      child: TextFormField(
        keyboardType: widget.tipoTeclado,
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Color.fromRGBO(158, 157, 157, 1)),
          filled: true,
          fillColor: AppColors.pastelBeige,
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: theme.overlayColor,
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: theme.overlayColor, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: theme.selectOverlayColor, width: 3),
          ),
        ),
      ),
    );
  }
}
