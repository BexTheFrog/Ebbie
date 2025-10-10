class UserModel {
  String? id;
  String nome;
  String email;
  String senha;
  int carteira;

  UserModel(this.id, this.nome, this.email, this.senha, this.carteira);

  Map<String, dynamic> mapUser() {
    return {'nome': nome, 'email': email, 'senha': senha, 'carteira': carteira};
  }

  factory UserModel.factoryUser(String id, Map<String, dynamic> map) {
    return UserModel(
      id,
      map['nome'],
      map['email'],
      map['senha'],
      map['carteira'],
    );
  }
}
