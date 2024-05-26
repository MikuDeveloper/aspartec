import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/subjects_provider.dart';
import '../../view/home/advisor/subjects_page.dart';
import '../../view/widgets/loading_widget.dart';

class SubjectsPageController extends ConsumerWidget {
  const SubjectsPageController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjects = ref.watch(subjectsProvider);
    return subjects.when(
      data: (subjects) {
        return RefreshIndicator(
          onRefresh: ref.read(subjectsProvider.notifier).loadSubjects,
          child: SubjectsPage(subjects: subjects),
        );
      },
      error: (error, stackTrace) => _SubjectsError(error: error, stackTrace: stackTrace),
      loading: () => const LoadingWidget(title: 'Cargando materias')
    );
  }
}

class _SubjectsError extends ConsumerWidget {
  final Object error;
  final StackTrace stackTrace;
  const _SubjectsError({required this.error, required this.stackTrace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Error al cargar materias'),
          const SizedBox(height: 15),
          TextButton(
            onPressed: ref.read(subjectsProvider.notifier).loadSubjects,
            child: const Text('Reintentar')
          )
        ],
      ),
    );
  }
}

