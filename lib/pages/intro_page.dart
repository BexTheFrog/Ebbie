import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/pages/bottom_nav.dart';
import 'package:ebbie/pages/signin_page.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/module_intropage/custom_btn.dart';
import 'package:flutter/material.dart';
import '../widgets/module_intropage/custom_form_field.dart';
import '../widgets/module_intropage/custom_form_label.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:flutter/services.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();

  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.pastelBeige, // Cor da barra de navegação
        systemNavigationBarIconBrightness: Brightness.dark, // Ícones escuros
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: Colors.transparent, // Status bar transparente
        statusBarIconBrightness: Brightness.dark, // Ícones do status bar escuros
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.pastelBeige,
        appBar: null, // Remove o AppBar completamente
        body: SafeArea( // Adiciona SafeArea como widget principal
          child: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 325,
                  right: 45,
                  width: 700,
                  child: Image.asset('assets/images/pedaco.png', fit: BoxFit.cover),
                ),

                Column(
                  children: [
                    SizedBox(height: 45),

                    Center(
                      child: Image.asset(
                        'assets/images/logo_gradient.png',
                        width: 300,
                      ),
                    ),

                    SizedBox(height: 35),

                    Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 0,
                        right: 10,
                        bottom: 0,
                      ),
                      alignment: Alignment.topCenter,
                      width: 330,
                      child: Text(
                        "Bem vindo ao Ebbie, seu novo planner estudantil",
                        style: TextStyle(
                          fontFamily: 'CerebriSansPro',
                          fontSize: 24,
                          color: AppColors.tealBlue,
                        ),
                      ),
                    ),

                    SizedBox(height: 25),

                    Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LabelsForm(title: 'Email:'),
                                SizedBox(height: 5),
                                CustomFormField(
                                  tipoTeclado: TextInputType.emailAddress,
                                  controller: controllerEmail,
                                  hintText: 'Usuario@mail.com',
                                  isPassword: false,
                                ),
                                SizedBox(height: 20),
                                LabelsForm(title: 'Senha:'),
                                SizedBox(height: 5),
                                CustomFormField(
                                  tipoTeclado: TextInputType.visiblePassword,
                                  controller: controllerSenha,
                                  hintText: 'Senha',
                                  isPassword: true,
                                ),
                                SizedBox(height: 40),
                                Center(
                                  child: BtnForm(
                                    title: 'Acessar',
                                    cor: AppColors.darkSlate,
                                    method: () async {
                                      String email = controllerEmail.text;
                                      String senha = controllerSenha.text;

                                      List<Map<String, dynamic>> resultados =
                                          await dbHelper.query(
                                            'user',
                                            where: 'email = ? AND senha = ?',
                                            whereArgs: [email, senha],
                                          );

                                      if (resultados.isNotEmpty) {
                                        int userId = resultados.first['id'];
                                        await UserService.saveUserId(userId);

                                        if (!mounted) return;
                                        Navigator.pushReplacementNamed(
                                          context,
                                          '/mainApp',
                                        );
                                      } else {
                                        if (!mounted) return;
                                        showDialog(
                                          context: context,
                                          builder: (_) => CustomMsgDialog(
                                            title: 'Erro',
                                            content: 'Email ou senha incorretos',
                                            ok: CustomOk(
                                              function: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),

                          // Remove o SafeArea interno e mantém apenas o Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BtnForm(
                                title: 'Criar Conta',
                                cor: AppColors.tealBlue,
                                method: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SigninPage(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: 30),
                              BtnForm(
                                title: 'Esqueci a Senha',
                                cor: AppColors.tealBlue,
                                method: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}