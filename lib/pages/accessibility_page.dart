import 'package:ebbie/widgets/custom_appbar_no_icon.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({super.key});

  void _showColorOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF7EDE2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        final themeController = Provider.of<ThemeController>(context);
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Selecione o modo de daltonismo:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              _colorOption(context, 'Normal', themeController, const [
                Color(0xFFEA6D5A),
                Color(0xFFD3D0A0),
                Color(0xFF9BC1BC),
              ]),
              _colorOption(context, 'Protanopia', themeController, const [
                Color(0xFFB56576),
                Color(0xFFEAAC8B),
                Color(0xFFE56B6F),
              ]),
              _colorOption(context, 'Deuteranopia', themeController, const [
                Color(0xFF6D597A),
                Color(0xFFB56576),
                Color(0xFFEAAC8B),
              ]),
              _colorOption(context, 'Tritanopia', themeController, const [
                Color(0xFF355070),
                Color(0xFF6D597A),
                Color(0xFFB56576),
              ]),
            ],
          ),
        );
      },
    );
  }

  Widget _colorOption(
    BuildContext context,
    String title,
    ThemeController controller,
    List<Color> colors,
  ) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: colors
            .map(
              (c) => Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black12, width: 1),
                ),
              ),
            )
            .toList(),
      ),
      onTap: () {
        controller.setDaltonismMode(title);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeController>().primaryColor;

    return Scaffold(
      appBar: const CustomAppbarNoIcon(segment: "Acessibilidade"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 70),

            InkWell(
              onTap: () => _showColorOptions(context),
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 400,
                height: 90,
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(3),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7EDE2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.visibility, color: themeColor),
                      const SizedBox(width: 8),
                      Text(
                        'Opções de Daltonismo',
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}
