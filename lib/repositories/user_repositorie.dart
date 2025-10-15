import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebbie/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Cria usuário e deixa o Firestore gerar o ID automaticamente
  Future<String> createUser(UserModel user) async {
    try {
      final docRef = await _firestore.collection('usuarios').add(user.toMap());
      return docRef.id; // retorna o id gerado
    } catch (e) {
      throw Exception("Erro ao criar usuário: $e");
    }
  }

  // Login simples: retorna UID se email + senha batem
  Future<String?> login(String email, String senha) async {
    try {
      final query = await _firestore
          .collection('usuarios')
          .where('email', isEqualTo: email)
          .where('senha', isEqualTo: senha)
          .get();

      if (query.docs.isNotEmpty) {
        return query.docs.first.id; // UID do usuário logado
      }
      return null;
    } catch (e) {
      throw Exception("Erro ao logar: $e");
    }
  }

  // Busca usuário pelo ID
  Future<UserModel?> getUserById(String id) async {
    try {
      final doc = await _firestore.collection('usuarios').doc(id).get();
      if (!doc.exists) return null;
      return UserModel.fromMap(id, doc.data()!);
    } catch (e) {
      throw Exception("Erro ao buscar usuário: $e");
    }
  }

  // Atualiza usuário
  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection('usuarios').doc(user.id).update(user.toMap());
    } catch (e) {
      throw Exception("Erro ao atualizar usuário: $e");
    }
  }

  // Deleta usuário
  Future<void> deleteUser(String id) async {
    try {
      await _firestore.collection('usuarios').doc(id).delete();
    } catch (e) {
      throw Exception("Erro ao deletar usuário: $e");
    }
  }
}
