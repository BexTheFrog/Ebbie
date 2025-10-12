import 'package:ebbie/models/cortex_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> salvarPet(CortexModel pet) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('fome', pet.fome);
  prefs.setInt('fit', pet.fit);
  prefs.setInt('higiene', pet.higiene);
  prefs.setString('nome', pet.nome);
  prefs.setStringList('acessorios', pet.acessorios);
  prefs.setString('ultimaVez', DateTime.now().toIso8601String());
}

Future<CortexModel> carregarPet() async {
  final prefs = await SharedPreferences.getInstance();
  final nome = prefs.getString('nome') ?? "Cortex";
  final fome = prefs.getInt('fome') ?? 50;
  final fit = prefs.getInt('fit') ?? 50;
  final higiene = prefs.getInt('higiene') ?? 50;
  final acessorios = prefs.getStringList('acessorios') ?? [];
  final ultimaVez = DateTime.tryParse(prefs.getString('ultimaVez') ?? "");

  final pet = CortexModel(nome, fome, fit, higiene, acessorios);

  if (ultimaVez != null) {
    pet.atualizarStatusPorTempo(ultimaVez);
  }

  return pet;
}
