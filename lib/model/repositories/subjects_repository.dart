import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/subject_entity.dart';

abstract class SubjectsRepository {
  Future getAdvisorsSubjects(String email) async {}
  Future getSubjectsForStudent(String email) async {}
  Future registerSubject(SubjectEntity subject) async {}
  Future deleteSubject(String id) async {}
}