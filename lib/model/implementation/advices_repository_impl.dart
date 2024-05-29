import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

import '../entities/advice_entity.dart';
import '../repositories/advices_repository.dart';

class AdvicesRepositoryImpl implements AdvicesRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

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
  loadEvidence(File file, String id) {
    final path = _storage.ref('evidences/${id}_${_auth.currentUser?.email}');
    final uploadTask = path.putFile(file,
        SettableMetadata(contentType: "image/${p.extension(file.path).substring(1)}")
    );
    return uploadTask;
  }

  @override
  Future<void> closeAdvice({required String id, required int rating, required String evidenceUrl}) async {
    try {
      final data = await _firestore.collection(_collection).doc(id).get();
      final advice = AdviceEntity.fromJson(data);
      if (advice.adviceStatus == 'Cancelada') {
        throw Exception('El estudiante ha cancelado la asesoría.');
      }
      await _firestore.collection(_collection).doc(id).update({
        'adviceStatus' : 'Cerrada',
        'adviceAdvisorRating': rating,
        'adviceEvidenceUrl': evidenceUrl
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<void> ratingAdvisor(String id, int rating) async {
    try {
      await _firestore.collection(_collection).doc(id).update({
        'adviceStudentRating': rating
      });
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

  @override
  Future<String> getUrlFile(String path) async {
    try {
      return await _storage.ref(path).getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }
  
}