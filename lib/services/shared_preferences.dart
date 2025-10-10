import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  // ------------------- STRING -------------------

  static Future<void> setStringLocalStorage(String chave, String valor) async {
    final prefs = await _preferences;
    await prefs.setString(chave, valor);
  }

  static Future<String?> getStringLocalStorage(String chave) async {
    final prefs = await _preferences;
    return prefs.getString(chave);
  }

  // ------------------- INT -------------------
  static Future<void> setIntLocalStorage(String chave, int valor) async {
    final prefs = await _preferences;
    await prefs.setInt(chave, valor);
  }

  static Future<int?> getIntLocalStorage(String chave) async {
    final prefs = await _preferences;
    return prefs.getInt(chave);
  }

  // ------------------- DOUBLE -------------------
  static Future<void> setDoubleLocalStorage(String chave, double valor) async {
    final prefs = await _preferences;
    await prefs.setDouble(chave, valor);
  }

  static Future<double?> getDoubleLocalStorage(String chave) async {
    final prefs = await _preferences;
    return prefs.getDouble(chave);
  }

  // ------------------- BOOL -------------------
  static Future<void> setBoolLocalStorage(String chave, bool valor) async {
    final prefs = await _preferences;
    await prefs.setBool(chave, valor);
  }

  static Future<bool?> getBoolLocalStorage(String chave) async {
    final prefs = await _preferences;
    return prefs.getBool(chave);
  }

  // ------------------- LISTA DE STRINGS -------------------
  static Future<void> setStringListLocalStorage(
    String chave,
    List<String> valor,
  ) async {
    final prefs = await _preferences;
    await prefs.setStringList(chave, valor);
  }

  static Future<List<String>?> getStringListLocalStorage(String chave) async {
    final prefs = await _preferences;
    return prefs.getStringList(chave);
  }

  // ------------------- REMOVER ITEM -------------------
  static Future<void> removeLocalStorage(String chave) async {
    final prefs = await _preferences;
    await prefs.remove(chave);
  }

  // ------------------- LIMPAR TUDO -------------------
  static Future<void> clearLocalStorage() async {
    final prefs = await _preferences;
    await prefs.clear();
  }
}
