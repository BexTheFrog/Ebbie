import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int coinCount;

  const CustomAppBar({super.key, this.coinCount = 0});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.appbarColor,
        flexibleSpace: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 50),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: theme.pointsColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(247, 237, 226, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 25,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$coinCount',
                          style: TextStyle(
                            color: theme.pointsColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 3),
                         Icon(
                          Icons.paid,
                          color: theme.pointsColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
