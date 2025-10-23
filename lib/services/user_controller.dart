import 'package:flutter/material.dart';

class UserController with ChangeNotifier {
  String? _email;
  String? _nome;

  String? get email => _email;
  String? get nome => _nome;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setNome(String nome) {
    _nome = nome;
    notifyListeners();
  }
}
