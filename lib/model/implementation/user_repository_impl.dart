import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final String _collection = 'usuarios';

  @override
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<void> registerUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<void> registerOrUpdateData(UserEntity user) async {
    try {
      await _firestore.collection(_collection).doc(user.email).set(user.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future deleteUser() async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<UserEntity> getData(String email) async {
    try {
      final data = await _firestore.collection(_collection).doc(email).get();
      return UserEntity.fromJson(data.data());
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<void> sendEmailForReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  UploadTask updateAvatar(File file) {
    final path = _storage.ref('avatars/${_auth.currentUser?.email}');
    final uploadTask = path.putFile(file,
        SettableMetadata(contentType: "image/${p.extension(file.path).substring(1)}")
    );
    return uploadTask;
  }

  @override
  Future<String> getUrlFile(String path) async {
    try {
      return await _storage.ref(path).getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<void> updateDataUrl(String url) async {
    try {
      await _firestore.collection(_collection).doc(_auth.currentUser?.email).update({'photoUrl': url});
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }
}