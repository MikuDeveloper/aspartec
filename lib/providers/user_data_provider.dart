import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/entities/user_entity.dart';
import '../model/implementation/user_repository_impl.dart';

final avatarProvider = StateProvider.autoDispose<String?>((ref) => null);

final userDataProvider = StateNotifierProvider.autoDispose<UserDataNotifier, AsyncValue<UserEntity>>((ref) => UserDataNotifier());

class UserDataNotifier extends StateNotifier<AsyncValue<UserEntity>> {
  final userRepository = UserRepositoryImpl();
  final auth = FirebaseAuth.instance;

  UserDataNotifier() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    if (mounted) {
      try {
        state = const AsyncValue.loading();
        final data = await userRepository.getData(auth.currentUser!.email!);
        state = AsyncValue.data(data);
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }

  void setData(UserEntity user) {
    if(mounted) {
      state = AsyncValue.data(user);
    }
  }
}