import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  Color _primaryColor = const Color(0xFF9BC1BC);

  Color get primaryColor => _primaryColor;

  void setDaltonismMode(String mode) {
    switch (mode) {
      case 'Protanopia':
        _primaryColor = const Color(0xFFB56576);
        break;
      case 'Deuteranopia':
        _primaryColor = const Color(0xFF6D597A);
        break;
      case 'Tritanopia':
        _primaryColor = const Color(0xFF355070);
        break;
      default:
        _primaryColor = const Color(0xFF9BC1BC);
    }
    notifyListeners();
  }
}
