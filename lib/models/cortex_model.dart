import 'dart:async';

class CortexModel {
  String nome;
  int fome;
  int fit;
  int higiene;
  List<String> acessorios;
  Timer? _timer;

  CortexModel(this.nome, this.fome, this.fit, this.higiene, this.acessorios);

  CortexModel.inicial(this.nome)
    : fome = 50,
      fit = 50,
      higiene = 50,
      acessorios = [];

  Map<String, dynamic> mapCortex() {
    return {
      'nome': nome,
      'fome': fome,
      'fit': fit,
      'higiene': higiene,
      'acessorios': acessorios,
    };
  }

  factory CortexModel.factoryCortex(Map<String, dynamic> map) {
    return CortexModel(
      map['nome'],
      map['fome'],
      map['fit'],
      map['higiene'],
      List<String>.from(map['acessorios'] ?? []),
    );
  }

  void atualizarStatusPorTempo(DateTime ultimaVez) {
    final agora = DateTime.now();
    final diferenca = agora.difference(ultimaVez);

    final dias = diferenca.inDays;
    if (dias > 0) {
      fome = (fome - (3 * dias)).clamp(0, 100);
      fit = (fit - (2 * dias)).clamp(0, 100);
      higiene = (higiene - (1 * dias)).clamp(0, 100);
    }
  }

  void iniciarCiclo(Function() onUpdate) {
    _timer = Timer.periodic(const Duration(hours: 24), (timer) {
      fome = (fome - 3).clamp(0, 100);
      fit = (fit - 2).clamp(0, 100);
      higiene = (higiene - 1).clamp(0, 100);

      onUpdate();
    });
  }

  void pararCiclo() {
    _timer?.cancel();
  }

  void cortexFeed() {
    fome += (fit + 5).clamp(0, 100);
  }

  void cortexWorkOut() {
    fit = (fit + 5).clamp(0, 100);
  }

  void cortexClean() {
    higiene = (higiene + 5).clamp(0, 100);
  }

  void cortexDayPass() {}
}
