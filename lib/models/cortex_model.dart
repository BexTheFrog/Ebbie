class CortexModel {
  String nome;
  int fome;
  int fit;
  int higiene;
  List<String> acessorios;

  CortexModel(this.nome, this.fome, this.fit, this.higiene, this.acessorios);

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

  setPet() {}
}
