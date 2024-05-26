import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/entities/subject_entity.dart';
import '../model/implementation/subjects_respository_impl.dart';
import '../view/utils/form_values.dart';

//final currentSubjectsProvider = StateProvider<List<String>>((ref) => []);

final subjectsEntries = Provider.autoDispose((ref) {
  final subjects = ref.read(subjectsProvider.notifier).subjects;
  final currents = subjects.map((item) => item.subjectName!).toList();

  return subjectsList.map(
      (item) => DropdownMenuEntry(
      value: item,
      label: item,
      enabled: !currents.contains(item)
    )
  ).toList();
});

final subjectsProvider = StateNotifierProvider<SubjectsNotifier, AsyncValue<List<SubjectEntity>>>((ref) => SubjectsNotifier());

class SubjectsNotifier extends StateNotifier<AsyncValue<List<SubjectEntity>>> {
  final auth = FirebaseAuth.instance;
  final subjectsRepository = SubjectsRepositoryImpl();
  //late List<String> currentSubjects = [];
  late List<SubjectEntity> subjects = [];

  SubjectsNotifier() : super(const AsyncValue.loading()) {
    loadSubjects();
  }

  Future<void> loadSubjects() async {
    if (mounted) {
      try {
        state = const AsyncValue.loading();
        final data = await subjectsRepository.getAdvisorsSubjects(auth.currentUser!.email!);
        //currentSubjects = data.map((subject) => subject.subjectName!).toList();
        subjects = data;
        state = AsyncValue.data(data);
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}