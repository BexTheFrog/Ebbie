import 'package:ebbie/pages/about_page.dart';
import 'package:ebbie/pages/accessibility_page.dart';
import 'package:ebbie/pages/email_page.dart';
import 'package:ebbie/pages/name_page.dart';
import 'package:ebbie/pages/password_page.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:ebbie/widgets/custom_appbar_no_icon.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    final borderColor = const Color(0xFFF4F1BB);
    final backgroundColor = theme.optionSettingsColor;
    final appBackgroundColor = const Color(0xFFF7EDE2);

    return Scaffold(
      appBar: const CustomAppbarNoIcon(coinCount: 15, segment: 'Configurações'),
      backgroundColor: appBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Conta ---
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(
                  "Conta",
                  style: TextStyle(
                    color: theme.appbarColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),

              // Container com sombra para o grupo Conta
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    // Sombra principal na parte inferior
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(
                        10,
                        -1,
                      ), // Controla quanto para baixo
                      spreadRadius: -5, // Controla quanto "corta" de cima
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Email
                    Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        border: Border.all(color: borderColor, width: 5),
                      ),
                      child: ListTile(
                        title: Text(
                          "Email",
                          style: TextStyle(
                            color: borderColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'CerebriSansPro',
                          ),
                        ),
                        trailing: Text(
                          "user@mail",
                          style: TextStyle(
                            fontSize: 14,
                            color: borderColor,
                            fontFamily: 'CerebriSansPro',
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EmailPage(),
                            ),
                          );
                        },
                      ),
                    ),

                    // Nome
                    Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(color: borderColor, width: 5),
                      ),
                      child: ListTile(
                        title: Text(
                          "Name",
                          style: TextStyle(
                            color: borderColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'CerebriSansPro',
                          ),
                        ),
                        trailing: Text(
                          "User Name",
                          style: TextStyle(
                            fontSize: 14,
                            color: borderColor,
                            fontFamily: 'CerebriSansPro',
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NamePage(),
                            ),
                          );
                        },
                      ),
                    ),

                    // Senha
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        border: Border.all(color: borderColor, width: 5),
                      ),
                      child: ListTile(
                        title: Text(
                          "Senha",
                          style: TextStyle(
                            color: borderColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'CerebriSansPro',
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PasswordPage(),
                              ),
                            );
                          },
                          child: Icon(
                            LucideIcons.squareArrowRight,
                            size: 30,
                            color: borderColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Preferências ---
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(
                  "Preferências do Aplicativo",
                  style: TextStyle(
                    color: theme.appbarColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),

              // Container com sombra para o grupo Preferências
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    // Sombra principal na parte inferior
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(
                        10,
                        -1,
                      ), // Controla quanto para baixo
                      spreadRadius: -5, // Controla quanto "corta" de cima
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Notificações
                    // Container(
                    //   margin: const EdgeInsets.only(bottom: 0),
                    //   decoration: BoxDecoration(
                    //     color: backgroundColor,
                    //     borderRadius: const BorderRadius.only(
                    //       topLeft: Radius.circular(10),
                    //       topRight: Radius.circular(10),
                    //     ),
                    //     border: Border.all(color: borderColor, width: 3),
                    //   ),
                    //   child: ListTile(
                    //     title: Text(
                    //       "Notificações",
                    //       style: TextStyle(
                    //         color: borderColor,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //     trailing: Container(
                    //       width: 30,
                    //       height: 30,
                    //       decoration: BoxDecoration(
                    //         color: const Color(0xFF9BC1BC),
                    //         borderRadius: BorderRadius.circular(8),
                    //         border: Border.all(
                    //           color: Color(0xFFF4F1BB),
                    //           width: 3,
                    //         ),
                    //       ),
                    //       child: Icon(
                    //         Icons.arrow_forward_rounded,
                    //         size: 20,
                    //         color: borderColor,
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // // Vibração
                    // Container(
                    //   margin: const EdgeInsets.only(bottom: 0),
                    //   decoration: BoxDecoration(
                    //     color: backgroundColor,
                    //     border: Border.all(color: borderColor, width: 3),
                    //   ),
                    //   child: ListTile(
                    //     title: Text(
                    //       "Vibração",
                    //       style: TextStyle(
                    //         color: borderColor,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //     trailing: Text(
                    //       "Ativado",
                    //       style: TextStyle(fontSize: 14, color: borderColor),
                    //     ),
                    //   ),
                    // ),

                    // Acessibilidade
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: borderColor, width: 5),
                      ),
                      child: ListTile(
                        title: Text(
                          "Acessibilidade",
                          style: TextStyle(
                            color: borderColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'CerebriSansPro',
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccessibilityPage(),
                              ),
                            );
                          },
                          child: Icon(
                            LucideIcons.squareArrowRight,
                            size: 30,
                            color: borderColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Extras ---
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(
                  "Extras",
                  style: TextStyle(
                    color: theme.appbarColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    fontFamily: 'CerebriSansPro',
                  ),
                ),
              ),

              // Container com sombra para o grupo Extras
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    // Sombra principal na parte inferior
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(
                        10,
                        -1,
                      ), // Controla quanto para baixo
                      spreadRadius: -5, // Controla quanto "corta" de cima
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Deletar conta
                    Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        border: Border.all(color: borderColor, width: 5),
                      ),
                      child: ListTile(
                        title: Text(
                          "Deletar Conta",
                          style: TextStyle(
                            color: borderColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'CerebriSansPro',
                          ),
                        ),
                        trailing: Icon(
                          LucideIcons.squareArrowRight,
                          size: 30,
                          color: borderColor,
                        ),
                      ),
                    ),

                    // // Medalhas
                    // Container(
                    //   margin: const EdgeInsets.only(bottom: 0),
                    //   decoration: BoxDecoration(
                    //     color: backgroundColor,
                    //     border: Border.all(color: borderColor, width: 3),
                    //   ),
                    //   child: ListTile(
                    //     title: Text(
                    //       "Medalhas",
                    //       style: TextStyle(
                    //         color: borderColor,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //     trailing: Container(
                    //       width: 30,
                    //       height: 30,
                    //       decoration: BoxDecoration(
                    //         color: const Color(0xFF9BC1BC),
                    //         borderRadius: BorderRadius.circular(8),
                    //         border: Border.all(
                    //           color: Color(0xFFF4F1BB),
                    //           width: 3,
                    //         ),
                    //       ),
                    //       child: Icon(
                    //         Icons.arrow_forward_rounded,
                    //         size: 20,
                    //         color: borderColor,
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // // CheatMenu
                    // Container(
                    //   margin: const EdgeInsets.only(bottom: 0),
                    //   decoration: BoxDecoration(
                    //     color: backgroundColor,
                    //     border: Border.all(color: borderColor, width: 3),
                    //   ),
                    //   child: ListTile(
                    //     title: Text(
                    //       "CheatMenu",
                    //       style: TextStyle(
                    //         color: borderColor,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //     trailing: GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(builder: (context) => CheatPage()),
                    //         );
                    //       },
                    //       child: Container(
                    //         width: 30,
                    //         height: 30,
                    //         decoration: BoxDecoration(
                    //           color: const Color(0xFF9BC1BC),
                    //           borderRadius: BorderRadius.circular(8),
                    //           border: Border.all(
                    //             color: Color(0xFFF4F1BB),
                    //             width: 3,
                    //           ),
                    //         ),
                    //         child: Icon(
                    //           Icons.arrow_forward_rounded,
                    //           size: 20,
                    //           color: borderColor,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // Sobre Nós
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        border: Border.all(color: borderColor, width: 5),
                      ),
                      child: ListTile(
                        title: Text(
                          "Sobre Nós",
                          style: TextStyle(
                            color: borderColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'CerebriSansPro',
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AboutUsPage(),
                              ),
                            );
                          },
                          child: Icon(
                            LucideIcons.squareArrowRight,
                            size: 30,
                            color: borderColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
