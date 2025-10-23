import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/widgets/custom_appbar_no_icon.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:ebbie/widgets/widget_salvar/widget_salvar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  // final borderColor = const Color(0xFF5E586B); Não está em uso!!
  // final textColor = const Color(0xFF5D576B); Não está em uso!!
  final backgroundColor = const Color(0xFFF7EDE2);
  final appBackgroundColor = const Color(0xFFF7EDE2);

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

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
        });
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();
  final dbHelper = DatabaseHelper();
  int? userId;
  Map<String, dynamic>? userData;

  Future<void> _salvarSenha() async {
    final senha = _senhaController.text.trim();
    final confirmar = _confirmarSenhaController.text.trim();

    if (!_formKey.currentState!.validate()) return;

    if (senha != confirmar) {
      showDialog(
        context: context,
        builder: (_) => CustomMsgDialog(
          title: 'Atenção',
          content: 'As senhas não coincidem.',
          ok: CustomOk(function: () => Navigator.pop(context)),
        ),
      );
      return;
    }

    if (userData == null) {
      showDialog(
        context: context,
        builder: (_) => CustomMsgDialog(
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

    if (senha == userData!['senha']) {
      showDialog(
        context: context,
        builder: (_) => CustomMsgDialog(
          title: 'Ei!',
          content: 'Esta já é sua senha atual!',
          ok: CustomOk(function: () => Navigator.pop(context)),
        ),
      );
      return;
    }

    await dbHelper.update(
      'user',
      {'senha': senha},
      'id = ?',
      [userData!['id']],
    );

    showDialog(
      context: context,
      builder: (_) => CustomMsgDialog(
        title: 'Sucesso',
        content: 'Senha atualizada com sucesso!',
        ok: CustomOk(
          function: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserIdData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
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
                    color: theme.appbarColor,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: theme.appbarColor,
                          width: 2.5,
                        ),
                      ),
                      child: TextFormField(
                        controller: _senhaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'A senha é obrigatória';
                          }
                          if (value.length < 8) {
                            return 'A senha deve ter pelo menos 8 caracteres';
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(value) ||
                              !RegExp(r'[0-9]').hasMatch(value) ||
                              !RegExp(r'[!@#\$&*~.,;:?]').hasMatch(value)) {
                            return 'Use pelo menos 1 letra maiúscula, 1 número e 1 caractere especial';
                          }
                          return null;
                        },
                        obscureText: _obscureNewPassword,
                        decoration: InputDecoration(
                          hintText: "Nova senha...",
                          hintStyle: TextStyle(
                            color: theme.appbarColor.withOpacity(0.7),
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
                              color: theme.appbarColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureNewPassword = !_obscureNewPassword;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(
                          color: theme.appbarColor,
                          fontFamily: 'CerebriSansPro',
                        ),
                      ),
                    ),

                    // Campo Confirmar Senha
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: theme.appbarColor,
                          width: 2.5,
                        ),
                      ),
                      child: TextFormField(
                        controller: _confirmarSenhaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirme sua senha';
                          }
                          return null;
                        },
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          hintText: "Confirmar senha...",
                          hintStyle: TextStyle(
                            color: theme.appbarColor.withOpacity(0.7),
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
                              color: theme.appbarColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(
                          color: theme.appbarColor,
                          fontFamily: 'CerebriSansPro',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SalvarButtonWidget(
                  onPressed: () {
                    _salvarSenha();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
