import 'package:ebbie/models/modulo_model.dart';

class MateriaModel {
  String? id;
  String materia;
  ModuloModel modulo;

  MateriaModel(this.id, this.materia, this.modulo);

  Map<String, dynamic> mapMaterial() {
    return {'materia': materia, 'moduloId': modulo.id};
  }

  factory MateriaModel.factoryMaterial(
    String? id,
    Map<String, dynamic> map,
    ModuloModel modulo,
  ) {
    return MateriaModel(id, map['materia'], modulo);
  }
}
