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
      Container(), // Placeholder para o FAB central
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
        icon: const Icon(Icons.circle, color: Colors.transparent, size: 24),
        title: "",
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
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
      navBarHeight: 60,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.only(bottom: 8),
      navBarStyle: NavBarStyle.style3,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.zero,
        colorBehindNavBar: Colors.transparent,
      ),
      onItemSelected: (index) {
        if (_isFabOpen && index != 2) {
          _toggleFab();
        }
      },
    );
  }

  // ✅ FAB CENTRAL - POSIÇÃO CORRIGIDA
  Widget _buildCustomFloatingActionButton() {
    return Positioned(
      // ✅ POSIÇÃO PERFEITA: acima da navbar mas abaixo dos botões filhos
      bottom: 25, // Voltou para a posição original
      left: MediaQuery.of(context).size.width / 2 - 25,
      child: FloatingActionButton(
        onPressed: _toggleFab,
        backgroundColor: _isFabOpen
            ? const Color(0xFFED6A5A)
            : const Color(0xFFC0D9D5),
        foregroundColor: const Color(0xFFF4F1BB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 8,
        child: AnimatedRotation(
          turns: _isFabOpen ? 0.125 : 0.0,
          duration: const Duration(milliseconds: 250),
          child: Icon(_isFabOpen ? Icons.close : Icons.add, size: 24),
        ),
      ),
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
        extendBody: true,
        body: Stack(
          children: [
            // CONTEÚDO PRINCIPAL
            _buildMainContent(),

            // ✅ FAB CENTRAL - AGORA FICA ACIMA DO OVERLAY
            _buildCustomFloatingActionButton(),

            // ✅ OVERLAY E BOTÕES FAB - ORDEM CORRIGIDA
            if (_isFabOpen) ...[
              // Overlay escuro - FICA ATRÁS DO FAB
              GestureDetector(
                onTap: _toggleFab,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),

              // Botões filhos do FAB - FICAM ACIMA DO OVERLAY E DO FAB
              Positioned(
                // ✅ POSIÇÃO CORRIGIDA: acima do FAB central
                bottom: 100, // Acima do FAB (que está em bottom: 25 + altura do FAB)
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

                      // Botão Central - Pet (AGORA É O PET QUE FICA MAIS ALTO)
                      Positioned(
                        top: 0, // ✅ Este fica mais alto que os outros
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