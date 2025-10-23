import 'package:ebbie/pages/homepage.dart';
import 'package:ebbie/pages/pet_page.dart';
import 'package:ebbie/pages/pomodoro_page.dart';
import 'package:ebbie/pages/profile_page.dart';
import 'package:ebbie/pages/search_page.dart';
import 'package:ebbie/pages/settings_page.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/widgets/custom_msg_dialog.dart';
import 'package:ebbie/widgets/module_forms/custom_ok.dart';
import 'package:ebbie/widgets/module_forms/custom_review_form.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:flutter/services.dart';
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

  // Inicia o banco
  final dbHelper = DatabaseHelper();
  final DateTime _diaAtual = DateTime.now();

  Future<void> _loadUserId() async {
    int? id = await UserService.getUserId();
    setState(() {
      userId = id;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _controller = PersistentTabController(initialIndex: 0);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSystemUIOverlay();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSystemUIOverlay();
  }

  void _updateSystemUIOverlay() {
    final theme = context.read<ThemeController>();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: theme.appbarColor,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarContrastEnforced: true,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
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
      Container(), // Placeholder para o botão Mais (não navega)
      const PomodoroPage(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home, size: 24),
        title: "Home",
        activeColorPrimary: const Color(0xFFF4F1BB),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search, size: 24),
        title: "Buscar",
        activeColorPrimary: const Color(0xFFF4F1BB),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          _isFabOpen ? Icons.close : Icons.add,
          color: _isFabOpen ? const Color(0xFFED6A5A) : const Color(0xFF9BC1BC),
          size: 28,
        ),
        title: "Mais",
        activeColorPrimary: const Color(0xFF9BC1BC),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(LucideIcons.timer, size: 24),
        title: "Pomodoro",
        activeColorPrimary: const Color(0xFFF4F1BB),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person, size: 24),
        title: "Perfil",
        activeColorPrimary: const Color(0xFFF4F1BB),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  Widget _buildFabChild({required IconData icon, required VoidCallback onTap}) {
    final theme = context.watch<ThemeController>();
    return Material(
      shape: const CircleBorder(),
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
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: const Color(0xFFF4F1BB), size: 24),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    final theme = context.watch<ThemeController>();

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineToSafeArea: true,
      backgroundColor: theme.appbarColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: 70,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      navBarStyle: NavBarStyle.style3,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.zero,
        colorBehindNavBar: Colors.transparent,
      ),
      onItemSelected: (index) {
        if (index == 2) {
          // Botão Mais - apenas abre/fecha os botões, não navega
          _toggleFab();
          // Volta para a tela anterior
          Future.delayed(Duration.zero, () {
            if (_controller.index == 2) {
              _controller.index = 0;
            }
          });
        } else if (_isFabOpen) {
          // Se clicar em outro item e o FAB estiver aberto, fecha
          _toggleFab();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    final screenWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: theme.appbarColor,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarContrastEnforced: true,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            // CONTEÚDO PRINCIPAL
            _buildMainContent(),

            // ✅ OVERLAY E BOTÕES DO BOTÃO "MAIS"
            if (_isFabOpen) ...[
              // Overlay escuro
              GestureDetector(
                onTap: _toggleFab,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),

              // Botões filhos
              Positioned(
                bottom: 80, // Posicionado acima da navbar
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 80,
                  child: Stack(
                    children: [
                      // Botão Esquerdo - Adicionar Revisão
                      Positioned(
                        top: 20,
                        left: screenWidth / 2 - 120,
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                40 * (1 - _animationController.value),
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
                              if (userId == null) return;
                              
                              final modulos = await dbHelper.query(
                                'modulo',
                                where: 'idUsuario = ?',
                                whereArgs: [userId],
                              );

                              if (modulos.isEmpty) {
                                if (mounted) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomMsgDialog(
                                      title: 'Ops!',
                                      content:
                                          'Você ainda não cadastrou nenhum módulo. Crie um módulo antes de adicionar revisões.',
                                      ok: CustomOk(
                                        function: () => Navigator.pop(context),
                                      ),
                                    ),
                                  );
                                }
                                return;
                              }

                              await showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return CustomDialogRevieweForm(
                                    dataReview: _diaAtual,
                                    userId: userId!,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),

                      // Botão Central - Pet
                      Positioned(
                        top: 0,
                        left: screenWidth / 2 - 25,
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                50 * (1 - _animationController.value),
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
                                MaterialPageRoute(
                                  builder: (context) => const PetPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Botão Direito - Configurações
                      Positioned(
                        top: 20,
                        right: screenWidth / 2 - 120,
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                40 * (1 - _animationController.value),
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SettingsPage(),
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
            ],
          ],
        ),
      ),
    );
  }
}