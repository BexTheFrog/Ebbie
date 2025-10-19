import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {

  // Cor geral
  Color _textColor = Colors.white; // Cor para texto geral
  Color _appbarColor = const Color(0xFF5D576B); // Cor do appBar e navBar geral
  Color _pointsColor = const Color.fromRGBO(233, 167, 81, 1); // Cor pontos do pet geral

  // Cor Home
  Color _tablecalendarColor =  Color(0xFF5D576B);
  Color _calendarFimSemanaColor = Color.fromARGB(255, 255, 75, 75);
  Color _calendarDayColor = Color(0xFFF6BD60);
  Color _cerebroLineColor = Color(0xFF9BC1BC);
  Color _tituloCardReviwColor = Color(0xFFED6A5A);
  Color _subTituloCardReviwColor = Color(0xFF9BC1BC);
  Color _descricaoCardReviwColor = Color(0xFF5D576B);

  // Cor Pomodoro
  Color _primaryColor = const Color(0xFFEA6D5A); // Cor principal do Pomodoro
  Color _secondaryColor = const Color(0xFFD3D0A0); // Cor secundária do Pomodoro 
  Color _accentColor = const Color(0xFF9BC1BC); // Cor de itens do Pomodoro
  Color _textOverlayColor = const Color(0xFF5D576B); // Cor da Overlay Pomodoro
  Color _botomPlayColor = const Color(0xFFEA6D5A); // Cor do botão play Pomodoro
  Color _secondaryBotomColor = const Color(0xFFD3D0A0); // Cor do botão secundário Pomodoro
  

  String _daltonismMode = 'Normal';

  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;
  Color get accentColor => _accentColor;
  Color get textColor => _textColor;
  Color get appbarColor => _appbarColor;
  Color get textOverlayColor => _textOverlayColor;
  Color get pointsColor => _pointsColor;
  Color get botomPlayColor => _botomPlayColor;
  Color get secondaryBotomColor => _secondaryBotomColor;
  Color get tableCalendarColor => _tablecalendarColor;
  Color get calendarFimSemanaColor => _calendarFimSemanaColor;
  Color get calendarDayColor => _calendarDayColor;
  Color get cerebroLineColor => _cerebroLineColor;
  Color get tituloCardReviwColor => _tituloCardReviwColor;
  Color get subTituloCardReviwColor => _subTituloCardReviwColor;
  Color get descricaoCardReviwColor => _descricaoCardReviwColor;


  String get daltonismMode => _daltonismMode;

  void setDaltonismMode(String mode) {
    _daltonismMode = mode;

    switch (mode) {
      case 'Protanopia':
        // Cor geral
        _textColor = Colors.white; // Cor para texto geral
        _appbarColor = const Color(0xFF2e2e2e); // Cor do appBar e navBar geral
        _pointsColor = const Color(0xFFB56576); // Cor pontos do pet geral

        // Cor homepage
        _tablecalendarColor = Color(0xFF4B3A4B);
        _calendarFimSemanaColor = Color(0xFFE56B6F);
        _calendarDayColor = Color(0xFFEAAC8B);
        _cerebroLineColor = Color(0xBFE56B6F);
        _tituloCardReviwColor = Color(0xFFB56576);
        _subTituloCardReviwColor = Color(0xFFE56B6F);
        _descricaoCardReviwColor = Color(0xFFE56B6F);

        // Cor Pomodoro
        _primaryColor = const Color(0xFFB56576); // Cor principal do Pomodoro
        _secondaryColor = const Color(0xFFEAAC8B); // Cor secundária do Pomodoro
        _accentColor = const Color(0xFFE56B6F); // Cor de itens do Pomodoro
        _textOverlayColor = const Color(0xFF3C2F3C); // Cor da Overlay Pomodoro
        _botomPlayColor = const Color(0xFFE56B6F); // Cor do botão play Pomodoro
        _secondaryBotomColor = const Color(0xFFEAAC8B); // Cor do botão secundário Pomodoro
        break;

case 'Deuteranopia':
        // Cor geral
        _textColor = Colors.white; // Cor para texto geral
        _appbarColor = const Color(0xFF4A3F4A); // Cor do appBar e navBar geral
        _pointsColor = const Color(0xFFEAAC8B); // Cor pontos do pet geral

        // Cor homepage
        _tablecalendarColor = Color(0xFF3D303D);
        _calendarFimSemanaColor = Color(0xFFB56576);
        _calendarDayColor = Color(0xFFB56576);
        _cerebroLineColor = Color(0xBF4A3F4A);
        _tituloCardReviwColor = Color(0xFFEAAC8B);
        _subTituloCardReviwColor = Color(0xFF4B3A4B);
        _descricaoCardReviwColor = Color(0xFF4A3F4A);

        // Cor Pomodoro
        _primaryColor = const Color(0xFF6D597A); // Cor principal do Pomodoro
        _secondaryColor = const Color(0xFFB56576); // Cor secundária do Pomodoro
        _accentColor = const Color(0xFFEAAC8B); // Cor de itens do Pomodoro
        _textOverlayColor = const Color(0xFF3D303D); // Cor da Overlay Pomodoro
        _botomPlayColor = const Color(0xFFEAAC8B); // Cor do botão play Pomodoro
        _secondaryBotomColor = const Color(0xFF4A3F4A); // Cor do botão secundário Pomodoro
        break;

case 'Tritanopia':
        // Cor geral
        _textColor = Colors.white; // Cor para texto geral
        _appbarColor = const Color(0xFF2F3B50); // Cor do appBar e navBar geral
        _pointsColor = const Color(0xFFB56576); // Cor pontos do pet geral

        // Cor homepage
        _tablecalendarColor = Color(0xFF2F3B50);
        _calendarFimSemanaColor = Color(0xFFAB87C3);
        _calendarDayColor = Color(0xFFAB87C3);
        _cerebroLineColor = Color(0xBF6D597A);
        _tituloCardReviwColor = Color(0xFF2F3B50);
        _subTituloCardReviwColor = Color(0xFF6D597A);
        _descricaoCardReviwColor = Color(0xFF6D597A);

        // Cor Pomodoro
        _primaryColor = const Color(0xFF355070); // Cor principal do Pomodoro
        _secondaryColor = const Color(0xFF6D597A); // Cor secundária do Pomodoro
        _accentColor = const Color(0xFFB56576); // Cor de itens do Pomodoro
        _textOverlayColor = const Color(0xFF3B4A66); // Cor da Overlay Pomodoro
        _botomPlayColor = const Color(0xFFB56576); // Cor do botão play Pomodoro
        _secondaryBotomColor = const Color(0xFF6D597A); // Cor do botão secundário Pomodoro
        break;

default:
        // Cor geral
        _textColor = Colors.white; // Cor para texto geral
        _appbarColor = const Color(0xFF5D576B); // Cor do appBar e navBar geral
        _pointsColor = const Color.fromRGBO(233, 167, 81, 1); // Cor pontos do pet geral

        // Cor homepage
        _tablecalendarColor = Color(0xFF5D576B);
        _calendarFimSemanaColor = Color.fromARGB(255, 255, 75, 75);
        _calendarDayColor = Color(0xFFF6BD60);
        _cerebroLineColor = Color(0xBF9BC1BC);
        _tituloCardReviwColor = Color(0xFFED6A5A);
        _subTituloCardReviwColor = Color(0xFF9BC1BC);
        _descricaoCardReviwColor = Color(0xFF5D576B);

        // Cor Pomodoro
        _primaryColor = const Color(0xFFEA6D5A); // Cor principal do Pomodoro
        _secondaryColor = const Color(0xFFD3D0A0); // Cor secundária do Pomodoro
        _accentColor = const Color(0xFF9BC1BC); // Cor de itens do Pomodoro
        _textOverlayColor = const Color(0xFF5D576B); // Cor da Overlay Pomodoro
        _botomPlayColor = const Color(0xFFEA6D5A); // Cor do botão play Pomodoro
        _secondaryBotomColor = const Color(0xFFD3D0A0); // Cor do botão secundário Pomodoro
        break;

    }

    notifyListeners();
  }
}
