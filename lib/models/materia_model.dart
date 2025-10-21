import 'package:ebbie/models/modulo_model.dart';

class MateriaModel {
  String? id;
  String? idUsuario;
  String? idModulo;
  String materia;
  ModuloModel modulo;

  MateriaModel({
    this.id,
    this.idUsuario,
    required this.materia,
    required this.modulo,
  });

  Map<String, dynamic> toMap() {
    return {'idUsuario': idUsuario, 'materia': materia, 'moduloId': modulo.id};
  }

  factory MateriaModel.fromMap(
    String? id,
    Map<String, dynamic> map,
    ModuloModel modulo,
  ) {
    return MateriaModel(
      id: id,
      idUsuario: map['idUsuario'],
      materia: map['materia'] ?? '',
      modulo: modulo,
    );
  }
}
