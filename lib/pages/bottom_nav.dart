import 'package:ebbie/pages/pet_page.dart';
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

// Importando suas páginas
import 'package:ebbie/pages/search_page.dart';
import 'package:ebbie/pages/pomodoro_page.dart';
import 'package:ebbie/pages/profile_page.dart';
import 'package:ebbie/pages/settings_page.dart';
import 'package:ebbie/pages/homepage.dart';

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
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarContrastEnforced: true,
      ),
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
      Container(),
      const PomodoroPage(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final theme = context.read<ThemeController>();

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
        icon: const Icon(Icons.circle, color: Colors.transparent, size: 24),
        title: "",
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
        onPressed: (context) => false,
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

  // ✅ ALTURA SIMPLIFICADA - EVITA OVERFLOW
  double _getTotalBottomBarHeight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return 60 + mediaQuery.viewPadding.bottom;
  }

  // Widget customizado que inclui a navbar E o FAB integrado
  Widget _buildCustomBottomBar(BuildContext context) {
    final theme = context.watch<ThemeController>();
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: _getTotalBottomBarHeight(context),
      color: theme.appbarColor,
      child: Stack(
        children: [
          // Navbar padrão do persistent_bottom_nav_bar
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
            navBarHeight: 60,
            navBarStyle: NavBarStyle.style3,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: const NavBarDecoration(
              borderRadius: BorderRadius.zero,
              colorBehindNavBar: Colors.transparent,
            ),
          ),

          // FAB INTEGRADO NO CENTRO DA NAVBAR
          Positioned(
            bottom: mediaQuery.viewPadding.bottom + 8,
            left: screenWidth / 2 - 25,
            child: Container(
              height: 50,
              width: 50,
              child: FloatingActionButton(
                onPressed: _toggleFab,
                backgroundColor: _isFabOpen
                    ? const Color(0xFFED6A5A) // 🔴 Vermelho quando ABERTO
                    : theme
                          .btnBottomNavColor, // ✅ #C0D9D5 SEMPRE quando FECHADO
                foregroundColor: const Color(0xFFF4F1BB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 4,
                child: AnimatedRotation(
                  turns: _isFabOpen ? 0.125 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(_isFabOpen ? Icons.close : Icons.add, size: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      extendBody: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: theme.appbarColor,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemStatusBarContrastEnforced: true,
          systemNavigationBarContrastEnforced: true,
        ),
        child: Stack(
          children: [
            // Conteúdo das páginas - COM RESIZE TO AVOID BOTTOM INSET
            PersistentTabView(
              context,
              controller: _controller,
              screens: _buildScreens(),
              items: _navBarsItems(),
              confineToSafeArea: true,
              backgroundColor: Colors.transparent,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              stateManagement: true,
              navBarHeight: 0,
              decoration: const NavBarDecoration(
                borderRadius: BorderRadius.zero,
                colorBehindNavBar: Colors.transparent,
              ),
            ),

            // Overlay para quando FAB estiver aberto
            if (_isFabOpen)
              GestureDetector(
                onTap: _toggleFab,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),

            // Botões filhos do FAB - POSIÇÃO MAIS SEGURA
            if (_isFabOpen)
              Positioned(
                bottom: _getTotalBottomBarHeight(context) + 60,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 80,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 30,
                        left: screenWidth / 2 - 110,
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
                              final modulos = await dbHelper.query(
                                'modulo',
                                where: 'idUsuario = ?',
                                whereArgs: [userId],
                              );

                              if (modulos.isEmpty) {
                                // Mostra aviso e sai
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

                              // Abre diálogo de review
                              final result = await showDialog(
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

                      Positioned(
                        top: 15,
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
                                  builder: (context) => PetPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      Positioned(
                        top: 30,
                        right: screenWidth / 2 - 110,
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

            // Navbar customizada com FAB integrado
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildCustomBottomBar(context),
            ),
          ],
        ),
      ),
    );
  }
}
