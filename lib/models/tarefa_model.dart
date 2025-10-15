import 'package:ebbie/models/materia_model.dart';

class TarefaModel {
  String? id;
  String idModulo;
  String idSection;
  String topico;
  DateTime dataRevisao;
  String status;
  bool wasReviewed;

  TarefaModel({
    this.id,
    required this.idModulo,
    required this.idSection,
    required this.topico,
    required this.dataRevisao,
    required this.status,
    this.wasReviewed = false,
  });

  // Converte o objeto em mapa (para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'idModulo': idModulo,
      'idSection': idSection,
      'topico': topico,
      'dataRevisao': dataRevisao.toIso8601String(),
      'status': status,
      'wasReviewed': wasReviewed,
    };
  }

  // Cria o objeto a partir de um mapa do Firestore
  factory TarefaModel.fromMap(String id, Map<String, dynamic> map) {
    return TarefaModel(
      id: id,
      idModulo: map['idModulo'] ?? '',
      idSection: map['idSection'] ?? '',
      topico: map['topico'] ?? '',
      dataRevisao: DateTime.parse(map['dataRevisao']),
      status: map['status'] ?? '',
      wasReviewed: map['wasReviewed'] ?? false,
    );
  }
}
