import 'package:flutter/material.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_service.dart';

class UserController with ChangeNotifier {
  final dbHelper = DatabaseHelper();

  int? userId;
  Map<String, dynamic>? userData;
  Map<String, int>? userStats;
  bool loading = false;

  Future<void> carregarUsuario() async {
    loading = true;
    notifyListeners();

    userId = await UserService.getUserId();
    if (userId != null) {
      final resultados = await dbHelper.query(
        'user',
        where: 'id = ?',
        whereArgs: [userId],
      );

      if (resultados.isNotEmpty) {
        userData = resultados.first;
        await carregarStats();
      }
    }

    loading = false;
    notifyListeners();
  }

  Future<void> carregarStats() async {
    if (userId != null && userData != null) {
      userStats = {
        'realizou': userData!['totalEstudadas'] ?? 0,
        'pulou': userData!['totalPuladas'] ?? 0,
        'memorizou': userData!['totalMemorizadas'] ?? 0,
      };
      notifyListeners();
    }
  }

  Future<void> atualizarUsuario(Map<String, dynamic> dados) async {
    if (userId != null) {
      await dbHelper.update('user', dados, 'id = ?', [userId]);
      await carregarUsuario();
    }
  }
}
