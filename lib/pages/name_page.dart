import 'package:ebbie/widgets/custom_appbar_no_icon.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:ebbie/widgets/widget_salvar/widget_salvar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  // final borderColor = const Color(0xFF5E586B); Não esta em uso!!
  // final textColor = const Color(0xFF5D576B); Não esta em uso!!
  final backgroundColor = const Color(0xFFF7EDE2);
  final appBackgroundColor = const Color(0xFFF7EDE2);

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
    final theme = context.watch<ThemeController>();
    return Scaffold(
      appBar: CustomAppbarNoIcon(segment: "Nome"),
      backgroundColor: appBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título do campo
              Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(
                  "Nome",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: theme.appbarColor,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),
              // Campo de email
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: theme.appbarColor, width: 2.5),
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Nome User already saved...",
                    hintStyle: TextStyle(
                      color: theme.appbarColor.withOpacity(0.7),
                      fontFamily: 'CerebriSansPro',
                    ),
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
                              border: Border.all(
                                color: theme.appbarColor,
                                width: 2,
                              ),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Icon(
                                Icons.clear,
                                size: iconSize,
                                color: theme.appbarColor,
                              ),
                              onPressed: () {
                                _emailController.clear();
                              },
                            ),
                          )
                        : null,
                  ),
                  style: TextStyle(
                    color: theme.appbarColor,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SalvarButtonWidget(onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
