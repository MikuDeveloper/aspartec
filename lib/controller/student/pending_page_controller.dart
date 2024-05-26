import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../globals.dart';
import '../../providers/advices_provider.dart';
import '../../view/home/student/pending_page.dart';
import '../../view/widgets/loading_widget.dart';

class PendingPageController extends ConsumerWidget {
  const PendingPageController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending = ref.watch(studentPendingProvider);
    return pending.when(
      data: (data) {
        studentPendingAdvicesList = data;
        return RefreshIndicator(
          onRefresh: ref.read(studentPendingProvider.notifier).loadAdvices,
          child: const PendingPage(),
        );
      },
      error: (error, stackTrace) => _PendingPageError(error: error, stackTrace: stackTrace),
      loading: () => const LoadingWidget(title: 'Cargando asesorías...')
    );
  }
}

class _PendingPageError extends ConsumerWidget {
  final Object error;
  final StackTrace stackTrace;
  const _PendingPageError({required this.error, required this.stackTrace});

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
            onPressed: ref.read(studentPendingProvider.notifier).loadAdvices,
            child: const Text('Reintentar')
          )
        ],
      ),
    );
  }
}
