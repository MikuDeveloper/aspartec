import 'dart:io';

import '../entities/advice_entity.dart';

abstract class AdvicesRepository {
  Future registerAdvice(AdviceEntity advice) async {}
  Future getStudentAdvicesByStatus({required String controlNumber, required String status}) async {}
  Future getAdvisorAdvicesByStatus({required String controlNumber, required String status}) async {}
  Future closeAdvice({required String id, required int rating, required String evidenceUrl}) async {}
  loadEvidence(File file, String id) async {}
  Future ratingAdvisor(String id, int rating) async {}
  Future cancelAdvice(String id) async {}
  Future getUrlFile(String path) async {}
}