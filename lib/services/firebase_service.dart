//Serviço utilizado para cadastrar os objetos no aplicativo, sem a necessidade de criar outros arquivos
//Serviço do Firebase com CRUD
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final String
  collection; //collection é a forma de guardar os dados, usado para varias colecoes, desde visitar nome de usuario e entre outros
  final FirebaseFirestore _firestore = FirebaseFirestore
      .instance; //INSTANCIANDO O BANCO DEDADOS  //So vai ser utlizada dentro dessa classe ao colocar o UNDERLINE

  FirebaseService(
    this.collection,
  ); //Método construtor de objeto a partir de uma instância

  //TODOS os metodos serao asincronos, eperando uma resposta antes de executar e toda funcao asincrona é future

  //CREATE
  Future<String> create(Map<String, dynamic> dados) async {
    //Future é usado por ser asincrono
    try {
      final doc = await _firestore
          .collection(collection)
          .add(dados); //"dados" podem ser definidos depois. Ex:carro, user, etc
      return doc.id;
    } catch (erro) {
      throw Exception("Não foi possível criar os dados: $erro");
    }
  }

  //READ GET BY ID
  Future<Map<String, dynamic>?> readById(String id) async {
    // A "?" interrogação é a possibilidade do valor ser nulo
    try {
      final doc = await _firestore.collection(collection).doc(id).get();
      // if(doc.exists){
      //   return doc.data();
      // }
      // return null;
      return doc.exists
          ? doc.data()
          : null; //Documento existe? caso o contrario retorne nulo
    } catch (erro) {
      throw Exception("Não foi possivel ler os dados: $erro");
    }
  }

  //READ ALL, retorna toda a lista do banco
  Future<List<Map<String, dynamic>>> readAll() async {
    try {
      final listAll = await _firestore.collection(collection).get();
      return listAll.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList(); //... Restante dos doc
    } catch (erro) {
      throw Exception("Não foi possível verificar a lista de dados: $erro");
    }
  }

  //UPDATE
  Future<void> update(String id, Map<String, dynamic> dados) async {
    try {
      await _firestore.collection(collection).doc(id).update(dados);
    } catch (erro) {
      throw Exception("Não foi possível atualizar os dados: $erro");
    }
  }

  //DELETE
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(collection).doc(id).delete();
    } catch (erro) {
      throw Exception("Não foi possível deletar o item solicitado: $erro");
    }
  }

  //CREATE COM ID ESPECÍFICO
  Future<void> createWithId(String id, Map<String, dynamic> dados) async {
    try {
      await _firestore.collection(collection).doc(id).set(dados);
    } catch (erro) {
      throw Exception("Não foi possível criar os dados com ID: $erro");
    }
  }
}
