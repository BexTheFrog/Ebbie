import 'package:ebbie/pages/pet_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

class _BottomNavState extends State<BottomNav> {
  int index = 0;
  final isDialOpen = ValueNotifier(false);

  // Defina as cores que você deseja usar aqui
  final Color navBarColor = const Color(0xFF5D576B);
  final Color navBarIconsColor = const Color(0xFFF4F1BB);
  final Color fabBackgroundColor = const Color(0xFF5D576B);
  final Color fabIconsColor = const Color(0xFFF4F1BB);
  final Color fabChildrenBackground = const Color(0xFF9BC1BC);
  final Color fabChildrenIconsColor = const Color(0xFFF4F1BB);

  final items = <Widget>[
    const Icon(Icons.home, size: 30),
    const Icon(Icons.search, size: 30),
    const Icon(Icons.timer, size: 30),
    const Icon(Icons.person, size: 30),
  ];

  late final screens = [
    MyHomePage(),
    SearchPage(),
    PomodoroPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: navBarColor,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.white,
            body: screens[index],
            bottomNavigationBar: Theme(
              data: Theme.of(
                context,
              ).copyWith(iconTheme: IconThemeData(color: navBarIconsColor)),
              child: CurvedNavigationBar(
                // AJUSTE A ALTURA DA BARRA DE NAVEGAÇÃO AQUI:
                height:
                    60.0, // ← VALOR PADRÃO É 75.0, REDUZA PARA DEIXAR MAIS BAIXA
                buttonBackgroundColor: const Color(0xFF5D576B),
                color: navBarColor,
                backgroundColor: Colors.transparent,
                animationDuration: const Duration(milliseconds: 500),
                index: index,
                items: items,
                onTap: (newIndex) {
                  setState(() {
                    index = newIndex;
                  });
                },
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SpeedDial(
                icon: Icons.add,
                activeIcon: Icons.close,
                backgroundColor: fabBackgroundColor,
                iconTheme: IconThemeData(color: fabIconsColor),
                overlayColor: const Color.fromARGB(255, 255, 255, 255),
                overlayOpacity: 0.5,
                spacing: 10,
                spaceBetweenChildren: 8,
                openCloseDial: isDialOpen,
                children: [
                  SpeedDialChild(
                    child: Icon(Icons.note_add, color: fabChildrenIconsColor),
                    backgroundColor: fabChildrenBackground,
                    label: "Adiciona nota",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  SpeedDialChild(
                    child: Icon(Icons.pets, color: fabChildrenIconsColor),
                    backgroundColor: fabChildrenBackground,
                    label: "Pet",
                    labelStyle: TextStyle(color: Colors.black),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PetPage()),
                      );
                    },
                  ),
                  SpeedDialChild(
                    child: Icon(Icons.settings, color: fabChildrenIconsColor),
                    backgroundColor: fabChildrenBackground,
                    label: "Configurações",
                    labelStyle: TextStyle(color: Colors.black),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
