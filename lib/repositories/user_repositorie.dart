import 'package:ebbie/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('usuarios').doc(user.id).set(user.toMap());
    } catch (e) {
      throw Exception("Erro ao criar usuário: $e");
    }
  }

  Future<UserModel?> getUserById(String id) async {
    try {
      final doc = await _firestore.collection('usuarios').doc(id).get();
      if (!doc.exists) return null;
      return UserModel.fromMap(id, doc.data()!);
    } catch (e) {
      throw Exception("Erro ao buscar usuário: $e");
    }
  }

  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('usuarios').doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String id) async {
    await _firestore.collection('usuarios').doc(id).delete();
  }
}
