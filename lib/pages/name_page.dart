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

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  int? userId;
  Map<String, dynamic>? userData;

  // final borderColor = const Color(0xFF5E586B); Não esta em uso!!
  // final textColor = const Color(0xFF5D576B); Não esta em uso!!

  final backgroundColor = const Color(0xFFF7EDE2);
  final appBackgroundColor = const Color(0xFFF7EDE2);

  final TextEditingController _nomeController = TextEditingController();
  final dbHelper = DatabaseHelper();

  // Controle do tamanho do X e do círculo
  final double circleSize = 30; // tamanho do círculo (altura/largura)
  final double iconSize = 18; // tamanho do X

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
          _nomeController.text = userData!['nome'] ?? '';
        });
      }
    }
  }

  Future<void> _salvarNome() async {
    final userController = Provider.of<UserController>(context, listen: false);
    final nome = _nomeController.text.trim();

    if (nome.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => CustomMsgDialog(
          title: 'Nada aqui',
          content: 'Por favor, insira um novo nome para atualizar.',
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

    if (nome == userData!['nome']) {
      showDialog(
        context: context,
        builder: (context) => CustomMsgDialog(
          title: 'Ei!',
          content: 'Insira um novo nome diferente do atual.',
          ok: CustomOk(function: () => Navigator.pop(context)),
        ),
      );
      return;
    }

    await dbHelper.update('user', {'nome': nome}, 'id = ?', [userData!['id']]);

    showDialog(
      context: context,
      builder: (context) => CustomMsgDialog(
        title: 'Sucesso',
        content: 'Nome atualizado!',
        ok: CustomOk(
          function: () {
            userController.setNome(nome);
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
    _nomeController.addListener(() {
      setState(() {}); // Atualiza para mostrar/esconder o X
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
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
                  controller: _nomeController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: userData?['Nome'] != null
                        ? "Nome atual: ${userData!['nome']}"
                        : "Digite um novo nome",
                    hintStyle: TextStyle(
                      color: theme.appbarColor.withOpacity(0.7),
                      fontFamily: 'CerebriSansPro',
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    border: InputBorder.none,
                    suffixIcon: _nomeController.text.isNotEmpty
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
                                _nomeController.clear();
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
                child: SalvarButtonWidget(
                  onPressed: () {
                    _salvarNome();
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
