import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/advice_entity.dart';
import '../repositories/advices_repository.dart';

class AdvicesRepositoryImpl implements AdvicesRepository {
  final _firestore = FirebaseFirestore.instance;
  final String _collection = 'asesorias';
  
  @override
  Future<void> registerAdvice(AdviceEntity advice) async {
    try {
      await _firestore.collection(_collection).doc(advice.id).set(advice.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<List<AdviceEntity>> getStudentAdvicesByStatus({required String controlNumber, required String status}) async {
    try {
      final data = await _firestore
          .collection(_collection)
          .where('studentControlNumber', isEqualTo: controlNumber)
          .where('adviceStatus', isEqualTo: status)
          .get();
      return data.docs.map((doc) => AdviceEntity.fromJson(doc)).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<List<AdviceEntity>> getAdvisorAdvicesByStatus({required String controlNumber, required String status}) async {
    try {
      final data = await _firestore
          .collection(_collection)
          .where('advisorControlNumber', isEqualTo: controlNumber)
          .where('adviceStatus', isEqualTo: status)
          .get();
      return data.docs.map((doc) => AdviceEntity.fromJson(doc)).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<void> closeAdvice({required String id, required int rating}) async {
    try {
      final data = await _firestore.collection(_collection).doc(id).get();
      final advice = AdviceEntity.fromJson(data);
      if (advice.adviceStatus == 'Cancelada') {
        throw Exception('El estudiante ha cancelado la asesoría.');
      }
      await _firestore.collection(_collection).doc(id).update({ 'adviceStatus' : 'Cerrada', 'adviceAdvisorRating': rating });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }
  
  @override
  Future<void> cancelAdvice(String id) async {
    try {
      final data = await _firestore.collection(_collection).doc(id).get();
      final advice = AdviceEntity.fromJson(data);
      if (advice.adviceStatus == 'Cerrada') {
        throw Exception('El asesor ya ha cerrado la asesoría.');
      }
      await _firestore.collection(_collection).doc(id).update({ 'adviceStatus':'Cancelada' });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }
  
}