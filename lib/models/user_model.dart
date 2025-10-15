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

  Map<String, dynamic> toMap() {
    //Do objeto para o MAP
    return {'nome': nome, 'email': email, 'senha': senha, 'carteira': carteira};
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    //COnverte do Map para o Objeto
    return UserModel(
      id,
      map["nome"],
      map["email"],
      map["senha"],
      map["carteira"],
    ); //A ordem importa
  }
}
