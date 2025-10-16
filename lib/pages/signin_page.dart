import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/models/user_model.dart';
import 'package:ebbie/widgets/module_intropage/custom_btn.dart';
import 'package:ebbie/widgets/module_intropage/custom_form_field.dart';
import 'package:ebbie/widgets/module_intropage/custom_form_label.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  final TextEditingController controllerConfirmaSenha = TextEditingController();
  final TextEditingController controllerNome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBeige,
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 180,
                right: 145,
                width: 475,
                child: Image.asset(
                  'assets/images/pedaco.png',
                  fit: BoxFit.fill,
                ),
              ),

              Column(
                children: [
                  SizedBox(height: 50),

                  Center(
                    child: Image.asset(
                      'assets/images/logo_azul.png',
                      width: 125,
                    ),
                  ),

                  SizedBox(height: 15),

                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 0,
                      right: 10,
                      bottom: 0,
                    ),
                    alignment: Alignment.topCenter,
                    width: 330,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Registre-se e salve seu progresso",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'CerebriSansPro',
                          fontSize: 24,
                          color: AppColors.tealBlue,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelsForm(title: 'Nome:'),
                              SizedBox(height: 5),
                              CustomFormField(
                                tipoTeclado: TextInputType.name,
                                controller: controllerNome,
                                hintText: 'Seu nome...',
                                isPassword: false,
                              ),
                              SizedBox(height: 10),
                              LabelsForm(title: 'Email:'),
                              SizedBox(height: 5),
                              CustomFormField(
                                tipoTeclado: TextInputType.emailAddress,
                                controller: controllerEmail,
                                hintText: 'User@mail.com...',
                                isPassword: false,
                              ),
                              SizedBox(height: 10),
                              LabelsForm(title: 'Senha:'),
                              SizedBox(height: 5),
                              CustomFormField(
                                tipoTeclado: TextInputType.visiblePassword,
                                controller: controllerSenha,
                                hintText: 'Senha...',
                                isPassword: true,
                              ),
                              SizedBox(height: 10),
                              LabelsForm(title: 'Confirme sua senha:'),
                              SizedBox(height: 5),
                              CustomFormField(
                                tipoTeclado: TextInputType.visiblePassword,
                                controller: controllerConfirmaSenha,
                                hintText: 'Confirme sua senha...',
                                isPassword: true,
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BtnForm(
                              title: 'Criar Conta',
                              cor: AppColors.darkSlate,
                              method: () async {},
                            ),
                            SizedBox(height: 10),
                            BtnForm(
                              title: 'Voltar',
                              cor: AppColors.tealBlue,
                              method: () {
                                Navigator.pop(context);
                              },
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
        ],
      ),
    );
  }
}
