import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../globals.dart';
import '../../providers/advices_provider.dart';
import '../../providers/subjects_provider.dart';
import '../../view/home/advisor/reports_page.dart';
import '../../view/widgets/loading_widget.dart';

class ReportsPageController extends ConsumerWidget {
  const ReportsPageController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(advisorCompletedProvider);
    return provider.when(
      data: (completedAdvices) {
        advisorCompletedAdvicesList = completedAdvices;
        final provider2 = ref.watch(advisorCanceledProvider);
        return provider2.when(
          data: (canceledAdvices) {
            advisorCanceledAdvicesList = canceledAdvices;
            final provider3 = ref.watch(subjectsProvider);
            return provider3.when(
              data: (subjects) {
                advisorSubjectsList = subjects;
                return RefreshIndicator(
                  onRefresh: ref.read(advisorCompletedProvider.notifier).loadAdvices,
                  child: const ReportsPage(),
                );
              },
              error: (error, stackTrace) => _ReportsPageError(error: error, stackTrace: stackTrace), 
              loading: () => const LoadingWidget(title: 'Cargando materias...')
            );
          },
          error: (error, stackTrace) => _ReportsPageError(error: error, stackTrace: stackTrace),
          loading: () => const LoadingWidget(title: 'Cargando asesorías canceladas...')
        );
      },
      error: (error, stackTrace) => _ReportsPageError(error: error, stackTrace: stackTrace),
      loading: () => const LoadingWidget(title: 'Cargando asesorías completadas...')
    );
  }
}

class _ReportsPageError extends ConsumerWidget {
  final Object error;
  final StackTrace stackTrace;
  const _ReportsPageError({required this.error, required this.stackTrace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Error al cargar página de reportes'),
          const SizedBox(height: 15),
          TextButton(
              onPressed: ref.read(advisorCompletedProvider.notifier).loadAdvices,
              child: const Text('Reintentar')
          )
        ],
      ),
    );
  }
}
