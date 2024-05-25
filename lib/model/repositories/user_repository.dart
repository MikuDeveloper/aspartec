import 'dart:io';

import '../entities/user_entity.dart';

abstract class UserRepository {
  Future login(String email, String password) async {}
  Future logout() async {}
  Future sendEmailForReset(String email) async {}
  Future registerUser(String email, String password) async {}
  Future registerOrUpdateData(UserEntity user) async {}
  Future deleteUser() async {}
  Future getData(String email) async {}
  updateAvatar(File file) {}
  Future getUrlFile(String path) async {}
  Future updateDataUrl(String url) async {}
}