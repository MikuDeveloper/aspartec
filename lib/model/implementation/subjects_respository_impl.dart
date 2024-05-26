import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/subject_entity.dart';
import '../repositories/subjects_repository.dart';

class SubjectsRepositoryImpl implements SubjectsRepository {
  final _firestore = FirebaseFirestore.instance;

  final String _collection = 'materias';

  @override
  Future<void> registerSubject(SubjectEntity subject) async {
    try {
      //final docRef = _firestore.collection(_collection).doc();
      //subject = subject.copyWith(id: docRef.id);
      await _firestore.collection(_collection).doc(subject.id).set(subject.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<void> deleteSubject(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<List<SubjectEntity>> getAdvisorsSubjects(String email) async {
    try {
      final data = await _firestore
          .collection(_collection)
          .where('advisorEmail', isEqualTo: email)
          .get();
      return data.docs.map((doc) => SubjectEntity.fromJson(doc)).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<List<SubjectEntity>> getSubjectsForStudent(String email) async {
    try {
      final data = await _firestore
          .collection(_collection)
          .where('advisorEmail', isNotEqualTo: email)
          .get();
      return data.docs.map((doc) => SubjectEntity.fromJson(doc)).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }
}