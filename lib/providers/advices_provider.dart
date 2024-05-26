import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../globals.dart';
import '../model/entities/advice_entity.dart';
import '../model/implementation/advices_repository_impl.dart';

final studentPendingProvider = StateNotifierProvider<StudentAdvicesPending, AsyncValue<List<AdviceEntity>>>((ref) => StudentAdvicesPending());

class StudentAdvicesPending extends StateNotifier<AsyncValue<List<AdviceEntity>>> {
  final advicesRepository = AdvicesRepositoryImpl();

  StudentAdvicesPending() : super(const AsyncValue.loading()) {
    loadAdvices();
  }

  Future<void> loadAdvices() async {
    if (mounted) {
      state = const AsyncValue.loading();
      try {
        final data = await advicesRepository.getStudentAdvicesByStatus(controlNumber: userData.controlNumber!, status: 'Abierta');
        state = AsyncValue.data(data);
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}