import 'package:ebbie/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomAppBarWithComeback extends StatelessWidget
    implements PreferredSizeWidget {
  final int coinCount;

  const CustomAppBarWithComeback({super.key, this.coinCount = 0});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          padding: EdgeInsets.only(top: 22),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            LucideIcons.circleArrowLeft,
            color: AppColors.pastelYellow,
            size: 35,
          ),
        ),
        leadingWidth: 75,
        backgroundColor: const Color.fromRGBO(93, 87, 108, 1),
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
                    color: const Color.fromRGBO(233, 167, 81, 1),
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
                          style: const TextStyle(
                            color: Color.fromRGBO(233, 167, 81, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Icon(
                          Icons.paid,
                          color: Color.fromRGBO(233, 167, 81, 1),
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
