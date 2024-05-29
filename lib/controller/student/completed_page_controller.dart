import 'package:aspartec/globals.dart';
import 'package:aspartec/view/home/student/completed_page.dart';
import 'package:aspartec/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/advices_provider.dart';

class CompletedPageController extends ConsumerWidget {
  const CompletedPageController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(studentCompletedProvider);
    return provider.when(
        data: (advices) {
          studentCompletedAdvicesList = advices;
          return RefreshIndicator(
            onRefresh: ref.read(studentCompletedProvider.notifier).loadAdvices,
            child: const CompletedPage(),
          );
        },
        error: (error, stackTrace) => _CompletedPageError(error: error, stackTrace: stackTrace),
        loading: () => const LoadingWidget(title: 'Cargando asesorías completadas...')
    );
  }
}

class _CompletedPageError extends ConsumerWidget {
  final Object error;
  final StackTrace stackTrace;
  const _CompletedPageError({required this.error, required this.stackTrace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Error al cargar asesorías'),
          const SizedBox(height: 15),
          TextButton(
              onPressed: ref.read(studentCompletedProvider.notifier).loadAdvices,
              child: const Text('Reintentar')
          )
        ],
      ),
    );
  }
}