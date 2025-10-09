import 'package:ebbie/models/materia_model.dart';

class TarefaModel {
  String? id;
  String topico;
  MateriaModel modulo;
  MateriaModel materia;
  DateTime dataRevisao;
  String status;

  TarefaModel(
    this.id,
    this.topico,
    this.modulo,
    this.materia,
    this.dataRevisao,
    this.status,
  );

  Map<String, dynamic> mapTarefa() {
    return {
      'topico': materia,
      'moduloId': modulo.id,
      'materiaId': materia.id,
      'dataRevisao': dataRevisao,
      'status': status,
    };
  }

  factory TarefaModel.factoryTarefa(
    String? id,
    Map<String, dynamic> map,
    MateriaModel modulo,
    MateriaModel materia,
  ) {
    return TarefaModel(
      id,
      map['tarefa'],
      modulo,
      materia,
      map['dataRevisao'],
      map['status'],
    );
  }
}
