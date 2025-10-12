import 'package:ebbie/widgets/custom_appbar_no_icon.dart.dart';
import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final borderColor = const Color(0xFF5E586B);
  final backgroundColor = const Color(0xFFF7EDE2);
  final appBackgroundColor = const Color(0xFFF7EDE2);
  final textColor = const Color(0xFF5D576B);

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarNoIcon(segment: "Senha"),
      backgroundColor: appBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo Nova Senha
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(
                  "Nova senha",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: borderColor, width: 2.5),
                ),
                child: TextField(
                  obscureText: _obscureNewPassword,
                  decoration: InputDecoration(
                    hintText: "Nova senha...",
                    hintStyle: TextStyle(
                      color: borderColor.withOpacity(0.7),
                      fontFamily: 'CerebriSansPro',
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNewPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: borderColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
                    ),
                  ),
                  style: TextStyle(
                    color: borderColor,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),

              // Campo Confirmar Senha
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(
                  "Confirmar senha",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: borderColor, width: 2.5),
                ),
                child: TextField(
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: "Confirmar senha...",
                    hintStyle: TextStyle(
                      color: borderColor.withOpacity(0.7),
                      fontFamily: 'CerebriSansPro',
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: borderColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  style: TextStyle(
                    color: borderColor,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
