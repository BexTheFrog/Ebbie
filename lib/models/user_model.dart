class UserModel {
  String? id;
  String nome;
  String email;
  String senha;

  UserModel(this.id, this.nome, this.email, this.senha);

  Map<String, dynamic> mapUser() {
    return {'nome': nome, 'email': email, 'senha': senha};
  }

  factory UserModel.factoryUser(String id, Map<String, dynamic> map) {
    return UserModel(id, map['nome'], map['email'], map['senha']);
  }
}
