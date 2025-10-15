class ModuloModel {
  String? id;
  String idUsuario;
  String titulo;
  String descricao;

  ModuloModel(this.id, this.idUsuario, this.titulo, this.descricao);

  Map<String, dynamic> toMap() {
    return {'idUsuario': idUsuario, 'titulo': titulo, 'descricao': descricao};
  }

  factory ModuloModel.fromMap(String? id, Map<String, dynamic> map) {
    return ModuloModel(
      id,
      map['idUsuario'] ?? '',
      map['titulo'] ?? '',
      map['descricao'] ?? '',
    );
  }
}
