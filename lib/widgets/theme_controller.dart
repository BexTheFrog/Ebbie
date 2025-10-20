import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  Color _primaryColor = const Color(0xFFEA6D5A);
  Color _secondaryColor = const Color(0xFFD3D0A0);
  Color _accentColor = const Color(0xFF9BC1BC);
  Color _textColor = Colors.white;
  Color _appbarColor = const Color(0xFF5D576B);
  Color _textOverlayColor = const Color(0xFF5D576B);
  Color _pointsColor = const Color.fromRGBO(233, 167, 81, 1);
  Color _botomPlayColor = const Color(0xFFEA6D5A);
  Color _secondaryBotomColor = const Color(0xFFD3D0A0);

  String _daltonismMode = 'Normal';

  // Adicione estas propriedades para a navbar
  Color get navBarIconsColor {
    // Retorna uma cor que contraste bem com appbarColor
    return _textColor; // Ou você pode definir uma cor específica
  }

  Color get navBarBackgroundColor {
    return _appbarColor;
  }

  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;
  Color get accentColor => _accentColor;
  Color get textColor => _textColor;
  Color get appbarColor => _appbarColor;
  Color get textOverlayColor => _textOverlayColor;
  Color get pointsColor => _pointsColor;
  Color get botomPlayColor => _botomPlayColor;
  Color get secondaryBotomColor => _secondaryBotomColor;

  String get daltonismMode => _daltonismMode;

  void setDaltonismMode(String mode) {
    _daltonismMode = mode;

    switch (mode) {
      case 'Protanopia':
        _primaryColor = const Color(0xFFB56576);
        _secondaryColor = const Color(0xFFEAAC8B);
        _accentColor = const Color(0xFFE56B6F);
        _textColor = Colors.white;
        _appbarColor = const Color(0xFF2e2e2e);
        _textOverlayColor = const Color(0xFF3C2F3C);
        _pointsColor = const Color(0xFFB56576);
        _botomPlayColor = const Color(0xFFE56B6F);
        _secondaryBotomColor = const Color(0xFFEAAC8B);
        break;

      case 'Deuteranopia':
        _primaryColor = const Color(0xFF6D597A);
        _secondaryColor = const Color(0xFFB56576);
        _accentColor = const Color(0xFFEAAC8B);
        _textColor = Colors.white;
        _appbarColor = const Color(0xFF4A3F4A);
        _textOverlayColor = const Color(0xFF3D303D);
        _pointsColor = const Color(0xFFEAAC8B);
        _botomPlayColor = const Color(0xFFEAAC8B);
        _secondaryBotomColor = const Color(0xFF4A3F4A);
        break;

      case 'Tritanopia':
        _primaryColor = const Color(0xFF355070);
        _secondaryColor = const Color(0xFF6D597A);
        _accentColor = const Color(0xFFB56576);
        _textColor = Colors.white;
        _appbarColor = const Color(0xFF2F3B50);
        _textOverlayColor = const Color(0xFF3B4A66);
        _pointsColor = const Color(0xFFB56576);
        _botomPlayColor = const Color(0xFFB56576);
        _secondaryBotomColor = const Color(0xFF6D597A);
        break;

      default:
        _primaryColor = const Color(0xFFEA6D5A);
        _secondaryColor = const Color(0xFFD3D0A0);
        _accentColor = const Color(0xFF9BC1BC);
        _textColor = Colors.white;
        _appbarColor = const Color(0xFF5D576B);
        _textOverlayColor = const Color(0xFF5D576B);
        _pointsColor = const Color.fromRGBO(233, 167, 81, 1);
        _botomPlayColor = const Color(0xFFEA6D5A);
        _secondaryBotomColor = const Color(0xFFD3D0A0);
        break;
    }

    notifyListeners();
  }
}