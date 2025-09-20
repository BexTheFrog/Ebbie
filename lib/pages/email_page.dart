import 'package:ebbie/widgets/email_appbar.dart';
import 'package:flutter/material.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final borderColor = const Color(0xFF5E586B);
  final backgroundColor = const Color(0xFFF7EDE2);
  final appBackgroundColor = const Color(0xFFF7EDE2);
  final textColor = const Color(0xFF5D576B);

  final TextEditingController _emailController = TextEditingController();

  // Controle do tamanho do X e do círculo
  final double circleSize = 30; // tamanho do círculo (altura/largura)
  final double iconSize = 18; // tamanho do X

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {}); // Atualiza para mostrar/esconder o X
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmailAppbar(),
      backgroundColor: appBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título do campo
              const Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D576B),
                  ),
                ),
              ),
              // Campo de email
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: borderColor, width: 2.5),
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "User@mail.com User already saved...",
                    hintStyle:
                        TextStyle(color: borderColor.withOpacity(0.7)),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    border: InputBorder.none,
                    suffixIcon: _emailController.text.isNotEmpty
                        ? Container(
                            width: circleSize,
                            height: circleSize,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: backgroundColor,
                              border: Border.all(color: borderColor, width: 2),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Icon(
                                Icons.clear,
                                size: iconSize,
                                color: borderColor,
                              ),
                              onPressed: () {
                                _emailController.clear();
                              },
                            ),
                          )
                        : null,
                  ),
                  style: TextStyle(color: borderColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
