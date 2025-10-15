import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebbie/models/modulo_model.dart';

class ModuloRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Cria módulo e deixa o Firestore gerar o ID automaticamente
  Future<String> createModulo(ModuloModel modulo) async {
    try {
      final docRef = await _firestore.collection('modulos').add(modulo.toMap());
      return docRef.id; // retorna o id gerado automaticamente
    } catch (e) {
      throw Exception("Erro ao criar módulo: $e");
    }
  }

  // Busca módulo pelo ID
  Future<ModuloModel?> getModuloById(String id) async {
    try {
      final doc = await _firestore.collection('modulos').doc(id).get();
      if (!doc.exists) return null;
      return ModuloModel.fromMap(id, doc.data()!);
    } catch (e) {
      throw Exception("Erro ao buscar módulo: $e");
    }
  }

  // Atualiza módulo (dados completos)
  Future<void> updateModulo(ModuloModel modulo) async {
    try {
      await _firestore
          .collection('modulos')
          .doc(modulo.id)
          .update(modulo.toMap());
    } catch (e) {
      throw Exception("Erro ao atualizar módulo: $e");
    }
  }

  // Atualiza apenas campos específicos (ex: título, descrição)
  Future<void> updateCampos(String id, Map<String, dynamic> dados) async {
    try {
      await _firestore.collection('modulos').doc(id).update(dados);
    } catch (e) {
      throw Exception("Erro ao atualizar campos do módulo: $e");
    }
  }

  // busca modulos pelo id do usuário
  Future<List<ModuloModel>> getModulosByUsuario(String idUsuario) async {
    try {
      final query = await _firestore
          .collection('modulos')
          .where('idUsuario', isEqualTo: idUsuario)
          .get();

      return query.docs
          .map((doc) => ModuloModel.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Erro ao listar módulos: $e");
    }
  }

  // Deleta módulo
  Future<void> deleteModulo(String id) async {
    try {
      await _firestore.collection('modulos').doc(id).delete();
    } catch (e) {
      throw Exception("Erro ao deletar módulo: $e");
    }
  }
}
