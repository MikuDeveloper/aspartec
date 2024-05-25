import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../generated/assets.dart';
import '../../providers/user_data_provider.dart';
import '../../view/home/advisor/advisor_home_view.dart';
import '../../view/home/student/student_home_view.dart';
import '../../view/login/login_view.dart';
import '../../view/widgets/loading_widget.dart';

class HomeController extends ConsumerWidget {
  static const String routeName = 'home';
  const HomeController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.watch(userDataProvider);
    return userProvider.when(
      data: (user) {
        switch(user.type) {
          case 'advisor':
            return AdvisorHomeView(user: user);
          case 'student':
            return StudentHomeView(user: user, hiddenBar: false);
          //case 'admin': return ;
          default: return const LoginView();
        }
      },
      error: (error, stackTrace) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: _HomeErrorPage(error: error, stackTrace: stackTrace)
      ),
      loading: () => const Scaffold(
          resizeToAvoidBottomInset: false,
          body: LoadingWidget(title: 'Cargando datos de usuario')
      )
    );
  }
}

class _HomeErrorPage extends ConsumerWidget {
  final Object error;
  final StackTrace stackTrace;
  const _HomeErrorPage({required this.error, required this.stackTrace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          const Text('Error al cargar datos de usuario.'),
          const SizedBox(height: 15),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 150, maxHeight: 200),
            child: Image.asset(Assets.picturesDataError1),
          ),
          const SizedBox(height: 15),
          TextButton(
              onPressed: ref.read(userDataProvider.notifier).loadData,
              child: const Text('Reintentar')
          )
        ],
      ),
    );
  }
}
