import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/pages/signin_page.dart';
import 'package:ebbie/widgets/module_intropage/custom_btn.dart';
import 'package:flutter/material.dart';
import '../widgets/module_intropage/custom_form_field.dart';
import '../widgets/module_intropage/custom_form_label.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBeige,
      appBar: AppBar(backgroundColor: AppColors.pastelBeige, title: Text('')),
      body: Stack(
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
                              method: () {},
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),

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
    );
  }
}
