import 'package:ebbie/pages/accessibility_page.dart';
import 'package:ebbie/pages/bottom_nav.dart';
import 'package:ebbie/pages/intro_page.dart';
import 'package:ebbie/pages/profile_page.dart';
import 'package:ebbie/pages/settings_page.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class Ebbie extends StatefulWidget {
  const Ebbie({super.key});

  @override
  State<Ebbie> createState() => _EbbieState();
}

class _EbbieState extends State<Ebbie> {
  int? userId;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    try {
      int? id = await UserService.getUserId().timeout(
        const Duration(seconds: 5),
        onTimeout: () => null,
      );

      setState(() {
        userId = id;
        loading = false;
      });
    } catch (_) {
      setState(() {
        userId = null;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, _) {
        // Tela de loading enquanto busca o userId
        if (loading) {
          return const Material(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ebbie',
          locale: const Locale('pt', 'BR'),
          supportedLocales: const [Locale('pt', 'BR')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routes: {
            "/mainApp": (context) => const BottomNav(),
            "/Intro": (context) => const IntroPage(),
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: themeController.primaryColor,
            ),
            scaffoldBackgroundColor: const Color(0xFFFDF7E4),
            appBarTheme: AppBarTheme(
              backgroundColor: themeController.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
          // Página inicial decide pelo userId
          home: userId != null ? const BottomNav() : const IntroPage(),
        );
      },
    );
  }
}
