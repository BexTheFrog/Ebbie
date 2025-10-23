import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_controller.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/widgets/custom_appbar_no_icon.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:ebbie/widgets/widget_salvar/widget_salvar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final backgroundColor = const Color(0xFFF7EDE2);
  final appBackgroundColor = const Color(0xFFF7EDE2);

  final dbHelper = DatabaseHelper();

  int? userId;
  Map<String, dynamic>? userData;

  final TextEditingController _emailController = TextEditingController();

  final double circleSize = 30; // tamanho do círculo
  final double iconSize = 18; // tamanho do X

  @override
  void initState() {
    super.initState();
    _loadUserIdData();
    _emailController.addListener(() {
      setState(() {}); // Atualiza o X dinamicamente
    });
  }

  Future<void> _loadUserIdData() async {
    int? id = await UserService.getUserId();
    if (id != null) {
      final result = await dbHelper.query(
        'user',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isNotEmpty) {
        setState(() {
          userId = id;
          userData = result.first;
          _emailController.text = userData!['email'] ?? '';
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _salvarEmail() async {
    final userController = Provider.of<UserController>(context, listen: false);
    final email = _emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      showDialog(
        context: context,
        builder: (context) => CustomMsgDialog(
          title: 'Erro',
          content: 'Por favor, insira um e-mail válido.',
          ok: CustomOk(function: () => Navigator.pop(context)),
        ),
      );
      return;
    }

    if (userData == null) {
      showDialog(
        context: context,
        builder: (context) => CustomMsgDialog(
          title: 'Erro',
          content: 'Erro ao carregar dados do usuário.',
          ok: CustomOk(
            function: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
      );
      return;
    }

    await dbHelper.update(
      'user',
      {'email': email},
      'id = ?',
      [userData!['id']],
    );

    showDialog(
      context: context,
      builder: (context) => CustomMsgDialog(
        title: 'Sucesso',
        content: 'E-mail atualizado com sucesso!',
        ok: CustomOk(
          function: () {
            userController.email;
            Navigator.pop(context); // fecha o diálogo
            Navigator.pop(context); // volta para a tela anterior
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();

    return Scaffold(
      appBar: CustomAppbarNoIcon(segment: 'Email'),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: theme.appbarColor,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),

              // Campo de e-mail
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
                    hintText: userData?['email'] != null
                        ? "E-mail atual: ${userData!['email']}"
                        : "Digite seu e-mail",
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
                              onPressed: _emailController.clear,
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

              // Botão salvar
              Padding(
                padding: const EdgeInsets.all(16),
                child: SalvarButtonWidget(onPressed: _salvarEmail),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
