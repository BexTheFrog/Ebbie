import 'dart:async';

class CortexModel {
  String? id;
  String? idUsuario;
  String nome;
  double fome;
  double fit;
  double higiene;
  Timer? _timer;

  CortexModel(
    this.id,
    this.idUsuario,
    this.nome,
    this.fome,
    this.fit,
    this.higiene,
  );

  // Construtor inicial padrão (50% de cada atributo)
  CortexModel.inicial(this.nome)
    : fome = 0.5,
      fit = 0.5,
      higiene = 0.5,
      id = null,
      idUsuario = null;

  // Converter para map (Firestore)
  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'nome': nome,
      'fome': fome,
      'fit': fit,
      'higiene': higiene,
    };
  }

  // Criar a partir de map (Firestore)
  factory CortexModel.fromMap(String? id, Map<String, dynamic> map) {
    return CortexModel(
      id,
      map['idUsuario'],
      map['nome'] ?? '',
      (map['fome'] ?? 0.5).toDouble().clamp(0.0, 1.0),
      (map['fit'] ?? 0.5).toDouble().clamp(0.0, 1.0),
      (map['higiene'] ?? 0.5).toDouble().clamp(0.0, 1.0),
    );
  }

  // Atualiza os status com base em dias que se passaram
  void atualizarStatusPorTempo(DateTime ultimaVez) {
    final agora = DateTime.now();
    final diferenca = agora.difference(ultimaVez);
    final dias = diferenca.inDays;

    if (dias > 0) {
      fome = (fome - (0.03 * dias)).clamp(0.0, 1.0);
      fit = (fit - (0.02 * dias)).clamp(0.0, 1.0);
      higiene = (higiene - (0.01 * dias)).clamp(0.0, 1.0);
    }
  }

  // Inicia um ciclo automático (simulando queda diária)
  void iniciarCiclo(Function() onUpdate) {
    _timer = Timer.periodic(const Duration(hours: 24), (timer) {
      fome = (fome - 0.03).clamp(0.0, 1.0);
      fit = (fit - 0.02).clamp(0.0, 1.0);
      higiene = (higiene - 0.01).clamp(0.0, 1.0);
      onUpdate();
    });
  }

  void pararCiclo() {
    _timer?.cancel();
  }

  // Ações que aumentam os valores até no máximo 1.0
  void cortexFeed() {
    fome = (fome + 0.02).clamp(0.0, 1.0);
  }

  void cortexWorkOut() {
    fit = (fit + 0.02).clamp(0.0, 1.0);
  }

  void cortexClean() {
    higiene = (higiene + 0.02).clamp(0.0, 1.0);
  }
}
