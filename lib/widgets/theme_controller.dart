import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeController() {
    _loadDaltonismMode();
  }

  Future<void> _loadDaltonismMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString('daltonismMode') ?? 'Normal';
    setDaltonismMode(savedMode);
  }

  Future<void> _saveDaltonismMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('daltonismMode', mode);
  }

  // Cor geral
  Color _textColor = Colors.white; // Cor para texto geral
  Color _appbarColor = const Color(0xFF5D576B); // Cor do appBar e navBar geral
  Color _pointsColor = const Color.fromRGBO(
    233,
    167,
    81,
    1,
  ); // Cor pontos do pet gera
  Color _overlayColor = Color(0xFF9BC1BC);
  Color _selectOverlayColor = Color(0xFF5D576B);
  Color _btnBottomNavColor = Color(0xFFC0D9D5);
  Color _excluirBtnColor = Color(0xFFED6A5A);

  // Cor Home
  Color _tablecalendarColor = Color(0xFF5D576B);
  Color _calendarFimSemanaColor = Color.fromARGB(255, 255, 75, 75);
  Color _calendarDayColor = Color(0xFFF6BD60);
  Color _formReviewColor = Color(0xFF9BC1BC);
  Color _cerebroLineColor = Color(0xFF9BC1BC);
  Color _tituloCardReviwColor = Color(0xFFED6A5A);
  Color _subTituloCardReviwColor = Color(0xFF9BC1BC);
  Color _tarefasTituloCardColor = Color(0xFFED6A5A);
  Color _tarefasSubTituloCardColor = Color(0xFF9BC1BC);

  // Cor Search
  Color _searchColor = Color(0xFF9BC1BC);

  // Cor Pomodoro
  Color _primaryColor = const Color(0xFFEA6D5A); // Cor principal do Pomodoro
  Color _secondaryColor = const Color(0xFFD3D0A0); // Cor secundária do Pomodoro
  Color _accentColor = const Color(0xFF9BC1BC); // Cor de itens do Pomodoro
  Color _textOverlayColor = const Color(0xFF5D576B); // Cor da Overlay Pomodoro
  Color _timePersonalizedColor = const Color(
    0xFFD3D0A0,
  ); // Cor do tempo personalizado
  Color _botomPlayColor = const Color(0xFFEA6D5A); // Cor do botão play Pomodoro
  Color _secondaryBotomColor = const Color(
    0xFFD3D0A0,
  ); // Cor do botão secundário Pomodoro

  // Cor Profile
  Color _profileColor = Color(0xFFED6A5A);
  Color _dadosProfileColor = Color(0xFF5D576B);
  Color _lineDividerColor = Color(0xFFF4F1BB);
  Color _metaSelectProfileColor = Color(0xFFED6A5A);
  Color _metasProfileColor = Colors.orange.shade700;
  Color _revisaoMetaProfileColor = Color(0xFF9BC1BC);

  // Cor Pet
  Color _fundPetColor = Color(0xFFED6A5A).withAlpha(25);
  Color _namePetColor = Color(0xFFED6A5A);
  Color _layoutPetColor = Color(0xFFED6A5A);

  // Cor Settings
  Color _optionSettingsColor = Color(0xFF9BC1BC);

  // Cor About Page
  Color _aboutPageColor = Color(0xFF9BC1BC);
  Color _btnAboutPageColor = Color(0xFF5D576B);

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
  Color get timePersonalizedColor => _timePersonalizedColor;
  Color get pointsColor => _pointsColor;
  Color get excluirBtnColor => _excluirBtnColor;
  Color get botomPlayColor => _botomPlayColor;
  Color get btnBottomNavColor => _btnBottomNavColor;
  Color get secondaryBotomColor => _secondaryBotomColor;
  Color get tableCalendarColor => _tablecalendarColor;
  Color get calendarFimSemanaColor => _calendarFimSemanaColor;
  Color get calendarDayColor => _calendarDayColor;
  Color get cerebroLineColor => _cerebroLineColor;
  Color get tituloCardReviwColor => _tituloCardReviwColor;
  Color get subTituloCardReviwColor => _subTituloCardReviwColor;
  Color get tarefasTituloCardColor => _tarefasTituloCardColor; //
  Color get tarefasSubTituloCardColor => _tarefasSubTituloCardColor;
  Color get formReviewColor => _formReviewColor;
  Color get overlayColor => _overlayColor;
  Color get searchColor => _searchColor;
  Color get selectOverlayColor => _selectOverlayColor;
  Color get profileColor => _profileColor;
  Color get dadosProfileColor => _dadosProfileColor;
  Color get lineDividerColor => _lineDividerColor;
  Color get metaSelectProfileColor => _metaSelectProfileColor;
  Color get metasProfileColor => _metasProfileColor;
  Color get revisaoMetaProfileColor => _revisaoMetaProfileColor;
  Color get fundPetColor => _fundPetColor;
  Color get namePetColor => _namePetColor;
  Color get layoutPetColor => _layoutPetColor;
  Color get optionSettingsColor => _optionSettingsColor;
  Color get aboutPageColor => _aboutPageColor;
  Color get btnAboutPageColor => _btnAboutPageColor;

  String get daltonismMode => _daltonismMode;

  void setDaltonismMode(String mode) {
    _daltonismMode = mode;
    _saveDaltonismMode(mode);

    switch (mode) {
      case 'Protanopia':
        // Cor Geral
        _textColor = Colors.white; // Cor para texto geral
        _appbarColor = const Color(0xFF2e2e2e); // Cor do appBar e navBar geral
        _pointsColor = const Color(0xFFB56576); // Cor pontos do pet geral
        _overlayColor = Color(0xFFE56B6F); // Cor overlay geral
        _selectOverlayColor = Color(0xFFB56576);
        _excluirBtnColor = Color(0xFF2e2e2e);

        // Cor Homepage
        _tablecalendarColor = Color(0xFF4B3A4B);
        _calendarFimSemanaColor = Color(0xFFE56B6F);
        _calendarDayColor = Color(0xFFEAAC8B);
        _formReviewColor = Color(0xFFE56B6F);
        _cerebroLineColor = Color(0xBFE56B6F);
        _tituloCardReviwColor = Color(0xFFB56576);
        _subTituloCardReviwColor = Color(0xFFE56B6F);
        _tarefasTituloCardColor = Color(0xFFB56576);
        _tarefasSubTituloCardColor = Color(0xFF4B3A4B);
        _btnBottomNavColor = Color(0xFF4B3A4B);

        // Cor Search
        _searchColor = Color(0xFF3C2F3C);

        // Cor Pomodoro
        _primaryColor = const Color(0xFFB56576); // Cor principal do Pomodoro
        _secondaryColor = const Color(0xFFEAAC8B); // Cor secundária do Pomodoro
        _accentColor = const Color(0xFFE56B6F); // Cor de itens do Pomodoro
        _textOverlayColor = const Color(0xFF3C2F3C); // Cor da Overlay Pomodoro
        _timePersonalizedColor = const Color(
          0xFFEAAC8B,
        ); // Cor do tempo personalizado
        _botomPlayColor = const Color(0xFFE56B6F); // Cor do botão play Pomodoro
        _secondaryBotomColor = const Color(
          0xFFEAAC8B,
        ); // Cor do botão secundário Pomodoro

        // Cor Profile
        _profileColor = Color(0xFFE56B6F);
        _dadosProfileColor = Color(0xFF3C2F3C);
        _lineDividerColor = Color(0x4DE56B6F);
        _metaSelectProfileColor = Color(0xFF3C2F3C);
        _metasProfileColor = Color(0xFFB56576);
        _revisaoMetaProfileColor = Color(0x80EAAC8B);

        // Cor Pet
        _fundPetColor = Color(0xFFE56B6F).withAlpha(30);
        _namePetColor = Color(0xFFB56576);
        _layoutPetColor = Color(0xFFE56B6F);

        // Cor Settings
        _optionSettingsColor = Color(0xFFE56B6F);

        // Cor About Page
        _aboutPageColor = Color(0xFFE56B6F);
        _btnAboutPageColor = Color(0xFFB56576);
        break;

      case 'Deuteranopia':
        // Cor Geral
        _textColor = Colors.white; // Cor para texto geral
        _appbarColor = const Color(0xFF3D303D); // Cor do appBar e navBar geral
        _pointsColor = const Color(0xFFEAAC8B); // Cor pontos do pet geral
        _overlayColor = Color(0xFFB56576); // Cor overlay geral
        _selectOverlayColor = Color(0xFF6D597A);
        _excluirBtnColor = Color(0xFFB56576);

        // Cor Homepage
        _tablecalendarColor = Color(0xFF3D303D);
        _calendarFimSemanaColor = Color(0xFFB56576);
        _calendarDayColor = Color(0xFFB56576);
        _formReviewColor = Color(0xFFB56576);
        _cerebroLineColor = Color(0xBF4A3F4A);
        _tituloCardReviwColor = Color(0xFFEAAC8B);
        _subTituloCardReviwColor = Color(0xFF4B3A4B);
        _tarefasTituloCardColor = Color(0xFFEAAC8B);
        _tarefasSubTituloCardColor = Color(0xFF4A3F4A);
        _btnBottomNavColor = Color(0xFFEAAC8B);

        // Cor Search
        _searchColor = Color(0xFF6D597A);

        // Cor Pomodoro
        _primaryColor = const Color(0xFF6D597A); // Cor principal do Pomodoro
        _secondaryColor = const Color(0xFFB56576); // Cor secundária do Pomodoro
        _accentColor = const Color(0xFFEAAC8B); // Cor de itens do Pomodoro
        _textOverlayColor = const Color(0xFF3D303D); // Cor da Overlay Pomodoro
        _timePersonalizedColor = const Color(
          0xFFB56576,
        ); // Cor do tempo personalizado
        _botomPlayColor = const Color(0xFFEAAC8B); // Cor do botão play Pomodoro
        _secondaryBotomColor = const Color(
          0xFF4A3F4A,
        ); // Cor do botão secundário Pomodoro

        // Cor Profile
        _profileColor = Color(0xFF3D303D);
        _dadosProfileColor = Color(0xFF3D303D);
        _lineDividerColor = Color(0x4DEAAC8B);
        _metaSelectProfileColor = Color(0xFFB56576);
        _metasProfileColor = Color(0xFFEAAC8B);
        _revisaoMetaProfileColor = Color(0x806D597A);

        // Cor Pet
        _fundPetColor = Color(0xFFB56576).withAlpha(30);
        _namePetColor = Color(0xFF4A3F4A);
        _layoutPetColor = Color(0xFFEAAC8B);

        // Cor Settings
        _optionSettingsColor = Color(0xFFB56576);

        // Cor About Page
        _aboutPageColor = Color(0xFFB56576);
        _btnAboutPageColor = Color(0xFF4A3F4A);
        break;

      case 'Tritanopia':
        // Cor Geral
        _textColor = Colors.white; // Cor para texto geral
        _appbarColor = const Color(0xFF2F3B50); // Cor do appBar e navBar geral
        _pointsColor = const Color(0xFFB56576); // Cor pontos do pet geral
        _overlayColor = Color(0xFF6D597A); // Cor overlay geral
        _selectOverlayColor = Color(0xFFB56576);
        _excluirBtnColor = Color(0xFF6D597A);

        // Cor Homepage
        _tablecalendarColor = Color(0xFF2F3B50);
        _calendarFimSemanaColor = Color(0xFFAB87C3);
        _calendarDayColor = Color(0xFFAB87C3);
        _formReviewColor = Color(0xFF355070);
        _cerebroLineColor = Color(0xBF6D597A);
        _tituloCardReviwColor = Color(0xFF2F3B50);
        _subTituloCardReviwColor = Color(0xFF6D597A);
        _tarefasTituloCardColor = Color(0xFFB56576);
        _tarefasSubTituloCardColor = Color(0xFF355070);
        _btnBottomNavColor = Color(0xFF6D597A);

        // Cor Search
        _searchColor = Color(0xFF3B4A66);

        // Cor Pomodoro
        _primaryColor = const Color(0xFF355070); // Cor principal do Pomodoro
        _secondaryColor = const Color(0xFF6D597A); // Cor secundária do Pomodoro
        _accentColor = const Color(0xFFB56576); // Cor de itens do Pomodoro
        _textOverlayColor = const Color(0xFF3B4A66); // Cor da Overlay Pomodoro
        _timePersonalizedColor = const Color(
          0xFF6D597A,
        ); // Cor do tempo personalizado
        _botomPlayColor = const Color(0xFFB56576); // Cor do botão play Pomodoro
        _secondaryBotomColor = const Color(
          0xFF6D597A,
        ); // Cor do botão secundário Pomodoro

        // Cor Profile
        _profileColor = Color(0xFFB56576);
        _dadosProfileColor = Color(0xFF355070);
        _lineDividerColor = Color(0x4DB56576);
        _metaSelectProfileColor = Color(0xFF3B4A66);
        _metasProfileColor = Color(0xFF6D597A);
        _revisaoMetaProfileColor = Color(0x80B56576);

        // Cor Pet
        _fundPetColor = Color(0xFF2F3B50).withAlpha(25);
        _namePetColor = Color(0xFF2F3B50);
        _layoutPetColor = Color(0xFFB56576);

        // Cor Settings
        _optionSettingsColor = Color(0xFF355070);

        // Cor About Page
        _aboutPageColor = Color(0xFF355070);
        _btnAboutPageColor = Color(0xFF6D597A);
        break;

      default:
        // Cor Geral
        _textColor = Colors.white; // Cor para texto geral
        _appbarColor = const Color(0xFF5D576B); // Cor do appBar e navBar geral
        _pointsColor = const Color.fromRGBO(
          233,
          167,
          81,
          1,
        ); // Cor pontos do pet geral
        _overlayColor = Color(0xFF9BC1BC); // Cor overlay geral
        _selectOverlayColor = Color.fromARGB(255, 54, 123, 114);
        _excluirBtnColor = Color(0xFFED6A5A);

        // Cor Homepage
        _tablecalendarColor = Color(0xFF5D576B);
        _calendarFimSemanaColor = Color.fromARGB(255, 255, 75, 75);
        _calendarDayColor = Color(0xFFF6BD60);
        _formReviewColor = Color(0xFF9BC1BC);
        _cerebroLineColor = Color(0xBF9BC1BC);
        _tituloCardReviwColor = Color(0xFFED6A5A);
        _subTituloCardReviwColor = Color(0xFF9BC1BC);
        _tarefasTituloCardColor = Color(0xFFED6A5A);
        _tarefasSubTituloCardColor = Color(0xFF9BC1BC);
        _btnBottomNavColor = Color(0xFFC0D9D5);

        // Cor Search
        _searchColor = Color(0xFF9BC1BC);

        // Cor Pomodoro
        _primaryColor = const Color(0xFFEA6D5A); // Cor principal do Pomodoro
        _secondaryColor = const Color(0xFFD3D0A0); // Cor secundária do Pomodoro
        _accentColor = const Color(0xFF9BC1BC); // Cor de itens do Pomodoro
        _textOverlayColor = const Color(0xFF5D576B); // Cor da Overlay Pomodoro
        _timePersonalizedColor = const Color.fromARGB(
          255,
          182,
          176,
          114,
        ); // Cor do tempo personalizado
        _botomPlayColor = const Color(0xFFEA6D5A); // Cor do botão play Pomodoro
        _secondaryBotomColor = const Color(
          0xFFD3D0A0,
        ); // Cor do botão secundário Pomodoro

        // Cor Profile
        _profileColor = Color(0xFFED6A5A);
        _dadosProfileColor = Color(0xFF5D576B);
        _lineDividerColor = Color(0xFFF4F1BB);
        _metaSelectProfileColor = Color(0xFFED6A5A);
        _metasProfileColor = Colors.orange.shade700;
        _revisaoMetaProfileColor = Color(0xFF9BC1BC);

        // Cor Pet
        _fundPetColor = Color(0xFFED6A5A).withAlpha(25);
        _namePetColor = Color(0xFFED6A5A);
        _layoutPetColor = Color(0xFF9BC1BC);

        // Cor Settings
        _optionSettingsColor = Color(0xFF9BC1BC);

        // Cor About Page
        _aboutPageColor = Color(0xFF9BC1BC);
        _btnAboutPageColor = Color(0xFF5D576B);
        break;
    }

    notifyListeners();
  }
}
