import 'package:flutter/foundation.dart';

class AccessibilityProvider extends ChangeNotifier {
  bool _daltonismo = false;

  bool get daltonismo => _daltonismo;

  void setDaltonismo(bool value) {
    if (_daltonismo == value) return;
    _daltonismo = value;
    notifyListeners();
  }

  void toggleDaltonismo() {
    _daltonismo = !_daltonismo;
    notifyListeners();
  }
}
