import 'package:aspartec/globals.dart';
import 'package:aspartec/model/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/implementation/user_repository_impl.dart';
import '../../view/login/login_view.dart';
import '../../view/utils/show_alerts.dart';

class LogoutController extends StatefulWidget {
  const LogoutController({super.key});

  @override
  State<LogoutController> createState() => _LogoutControllerState();
}

class _LogoutControllerState extends State<LogoutController> {
  final userRepository = UserRepositoryImpl();

  void _logout() {
    ShowAlerts.openLogoutDialog(context)
    .then((accept) {
      if (accept) {
        userRepository.logout().then((_) {
          studentPendingAdvicesList = [];
          studentCompletedAdvicesList = [];
          advisorPendingAdvicesList = [];
          advisorCompletedAdvicesList = [];
          advisorCanceledAdvicesList = [];
          advisorSubjectsList = [];
          userData = UserEntity();
          context.goNamed(LoginView.routeName);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout_rounded),
      title: const Text('Cerrar sesión'),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: _logout,
    );
  }
}
