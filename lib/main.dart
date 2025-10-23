import 'package:ebbie/app.dart';
import 'package:ebbie/services/database.dart';
import 'package:ebbie/services/user_controller.dart';
import 'package:ebbie/services/user_service.dart';
import 'package:ebbie/services/wallet.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  final dbHelper = DatabaseHelper();
  final userId = await UserService.getUserId();

  // Inicializa coinNotifier
  if (userId != null) {
    final userData = await dbHelper.query(
      'user',
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (userData.isNotEmpty) {
      coinNotifier.value = userData[0]['carteira'] ?? 0;
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => UserController()),
      ],
      child: const Ebbie(),
    ),
  );
}
