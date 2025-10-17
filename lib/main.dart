import 'package:ebbie/app.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa formatação de datas
  await initializeDateFormatting('pt_BR', null);
  runApp(
    ChangeNotifierProvider(create: (_) => ThemeController(), child: Ebbie()),
  );
}
