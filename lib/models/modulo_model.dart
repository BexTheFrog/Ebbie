class ModuloModel {
  String? id;
  String modulo;

  ModuloModel(this.id, this.modulo);

  Map<String, dynamic> mapModulo() {
    return {'modulo': modulo};
  }

  factory ModuloModel.factoryModulo(String? id, Map<String, dynamic> map) {
    return ModuloModel(id, map['modulo']);
  }
}
