import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../globals.dart';
import '../../providers/advices_provider.dart';
import '../../view/home/advisor/advices_page.dart';
import '../../view/widgets/loading_widget.dart';

class AdvicesPageController extends ConsumerWidget {
  const AdvicesPageController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending = ref.watch(advisorPendingProvider);
    return pending.when(
      data: (advices) {
        advisorPendingAdvicesList = advices;
        return RefreshIndicator(
          onRefresh: ref.read(advisorPendingProvider.notifier).loadAdvices,
          child: const AdvicesPage(),
        );
      },
      error: (error, stackTrace) => _AdvicesPageError(error: error, stackTrace: stackTrace),
      loading: () => const LoadingWidget(title: 'Cargando asesorías...')
    );
  }
}

class _AdvicesPageError extends ConsumerWidget {
  final Object error;
  final StackTrace stackTrace;
  const _AdvicesPageError({required this.error, required this.stackTrace});

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
            onPressed: ref.read(advisorPendingProvider.notifier).loadAdvices,
            child: const Text('Reintentar')
          )
        ],
      ),
    );
  }
}

