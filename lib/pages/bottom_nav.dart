import 'package:ebbie/pages/pet_page.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/module_forms/custom_review_form.dart';
import 'package:ebbie/widgets/module_profile.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// Importando suas páginas
import 'package:ebbie/pages/search_page.dart';
import 'package:ebbie/pages/pomodoro_page.dart';
import 'package:ebbie/pages/profile_page.dart';
import 'package:ebbie/pages/settings_page.dart';
import 'package:ebbie/pages/homepage.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  late PersistentTabController _controller;
  late AnimationController _animationController;
  bool _isFabOpen = false;

  // Pegando UserId
  int? userId;

  Future<void> _loadUserId() async {
    int? id = await UserService.getUserId();
    setState(() {
      userId = id;
    });
  }

  // Cores
  final Color navBarColor = const Color(0xFF5D576B);
  final Color navBarIconsColor = const Color(0xFFF4F1BB);
  final Color fabBackgroundColor = const Color(0xFF5D576B);
  final Color fabIconsColor = const Color(0xFFF4F1BB);
  final Color fabChildrenBackground = const Color(0xFF9BC1BC);
  final Color fabChildrenIconsColor = const Color(0xFFF4F1BB);

  final DateTime _diaAtual = DateTime.now().add(const Duration(days: 1));

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _controller = PersistentTabController(initialIndex: 0);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250), // Animação mais rápida
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFab() {
    setState(() {
      _isFabOpen = !_isFabOpen;
      if (_isFabOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  List<Widget> _buildScreens() {
    return [
      const MyHomePage(),
      const SearchPage(),
      Container(), // Página vazia para o FAB
      const PomodoroPage(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: navBarIconsColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: "Buscar",
        activeColorPrimary: navBarIconsColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.circle, color: Colors.transparent),
        title: "",
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
        onPressed: (context) {
          // Não faz nada - desativa o clique
          return false;
        },
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(LucideIcons.timer),
        title: "Pomodoro",
        activeColorPrimary: navBarIconsColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Perfil",
        activeColorPrimary: navBarIconsColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  Widget _buildFabWithChildren() {
    final theme = context.watch<ThemeController>();
    return Stack(
      children: [
        // Overlay escuro quando aberto
        if (_isFabOpen)
          GestureDetector(
            onTap: _toggleFab,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.5),
            ),
          ),

        // Botões filhos em meia-lua com animação de 180°
        Positioned(
          bottom: 55,
          left: 0,
          right: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250), // Animação mais rápida
            height: _isFabOpen ? 120 : 0,
            child: Stack(
              children: [
                // Botão 1 - Esquerda
                Positioned(
                  top: 40,
                  left: MediaQuery.of(context).size.width / 2 - 110,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          0,
                          50 * (1 - _animationController.value),
                        ),
                        child: Transform.rotate(
                          angle: -0.3 * (1 - _animationController.value),
                          child: Opacity(
                            opacity: _animationController.value,
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: _buildFabChild(
                      icon: Icons.note_add,
                      onTap: () async {
                        _toggleFab();

                        final modules = await dbHelper.query(
                          'modulo',
                          where: 'idUsuario = ?',
                          whereArgs: [userId],
                        );

                        if (modules.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => CustomMsgDialog(
                              title: 'Aviso',
                              content:
                                  'Você precisa cadastrar pelo menos um módulo antes de adicionar uma review.',
                              ok: CustomOk(
                                function: () => Navigator.pop(context),
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return CustomDialogRevieweForm(
                                dataReview: _diaAtual,
                                userId: userId!,
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                // Botão 2 - Centro
                Positioned(
                  top: 20,
                  left: MediaQuery.of(context).size.width / 2 - 25,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          0,
                          60 * (1 - _animationController.value),
                        ),
                        child: Transform.rotate(
                          angle: 0.1 * (1 - _animationController.value),
                          child: Opacity(
                            opacity: _animationController.value,
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: _buildFabChild(
                      icon: Icons.gamepad_rounded,
                      onTap: () {
                        _toggleFab();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PetPage()),
                        );
                      },
                    ),
                  ),
                ),
                // Botão 3 - Direita (Settings)
                Positioned(
                  top: 40,
                  right: MediaQuery.of(context).size.width / 2 - 110,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          0,
                          50 * (1 - _animationController.value),
                        ),
                        child: Transform.rotate(
                          angle: 0.3 * (1 - _animationController.value),
                          child: Opacity(
                            opacity: _animationController.value,
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: _buildFabChild(
                      icon: Icons.settings,
                      onTap: () {
                        _toggleFab();
                        print('Ir para Configurações');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // FAB principal
        Positioned(
          bottom: 20,
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: FloatingActionButton(
            onPressed: _toggleFab,
            backgroundColor: theme.appbarColor,
            foregroundColor: fabIconsColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: AnimatedRotation(
              turns: _isFabOpen ? 0.125 : 0.0,
              duration: Duration(milliseconds: 250), // Animação mais rápida
              child: Icon(_isFabOpen ? Icons.close : Icons.add),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFabChild({required IconData icon, required VoidCallback onTap}) {
    final theme = context.watch<ThemeController>();
    return Material(
      shape: CircleBorder(),
      color: theme.appbarColor,
      elevation: 8,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: fabChildrenIconsColor, size: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();

    return Scaffold(
      body: Stack(
        children: [
          PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineToSafeArea: true,
            backgroundColor: theme.appbarColor,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            navBarStyle: NavBarStyle.style3,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(0.0),
              colorBehindNavBar: Colors.white,
            ),
          ),

          _buildFabWithChildren(),
        ],
      ),
    );
  }
}
