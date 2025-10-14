import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  // Cores principais do Pomodoro
  Color _primaryColor = const Color(0xFFEA6D5A);
  Color _secondaryColor = const Color(0xFFD3D0A0);
  Color _accentColor = const Color(0xFF9BC1BC);
  Color _textColor = Colors.white;
  Color _appbarColor = const Color(0xFF5D576B);
  Color _textOverlayColor = const Color(0xFF5D576B);

  String _daltonismMode = 'Normal';

  // Getters
  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;
  Color get accentColor => _accentColor;
  Color get textColor => _textColor;
  Color get appbarColor => _appbarColor;
  Color get textOverlayColor => _textOverlayColor;
  String get daltonismMode => _daltonismMode;

  void setDaltonismMode(String mode) {
    _daltonismMode = mode;

    switch (mode) {
      case 'Protanopia':
        _primaryColor = const Color(0xFFB56576);
        _secondaryColor = const Color(0xFFEAAC8B);
        _accentColor = const Color(0xFFE56B6F);
        _textColor = const Color(0xFF2E2E2E);
        _appbarColor = const Color(0xFF4B3A4B);
        _textOverlayColor = const Color(0xFF3C2F3C);
        break;

      case 'Deuteranopia':
        _primaryColor = const Color(0xFF6D597A);
        _secondaryColor = const Color(0xFFB56576);
        _accentColor = const Color(0xFFEAAC8B);
        _textColor = const Color(0xFF2E2E2E);
        _appbarColor = const Color(0xFF4A3F4A);
        _textOverlayColor = const Color(0xFF3D303D);
        break;

      case 'Tritanopia':
        _primaryColor = const Color(0xFF355070);
        _secondaryColor = const Color(0xFF6D597A);
        _accentColor = const Color(0xFFB56576);
        _textColor = const Color(0xFF2E2E2E);
        _appbarColor = const Color(0xFF2F3B50);
        _textOverlayColor = const Color(0xFF3B4A66);
        break;

      default:
        _primaryColor = const Color(0xFFEA6D5A);
        _secondaryColor = const Color(0xFFD3D0A0);
        _accentColor = const Color(0xFF9BC1BC);
        _textColor = Colors.white;
        _appbarColor = const Color(0xFF5D576B);
        _textOverlayColor = const Color(0xFF5D576B);
        break;
    }

    notifyListeners();
  }
}
