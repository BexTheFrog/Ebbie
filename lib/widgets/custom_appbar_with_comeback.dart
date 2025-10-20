import 'package:ebbie/config/app_colors.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:ebbie/services/wallet.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class CustomAppBarWithComeback extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithComeback({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();

    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          padding: const EdgeInsets.only(top: 22),
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            LucideIcons.circleArrowLeft,
            color: AppColors.pastelYellow,
            size: 35,
          ),
        ),
        leadingWidth: 75,
        backgroundColor: theme.appbarColor,
        flexibleSpace: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 50),
              Align(
                alignment: Alignment.centerRight,
                child: ValueListenableBuilder<int>(
                  valueListenable: coinNotifier,
                  builder: (context, coinCount, _) {
                    return Container(
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
                    );
                  },
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
