import 'package:aspartec/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../globals.dart';
import '../../model/entities/user_entity.dart';
import '../../model/implementation/user_repository_impl.dart';
import '../../view/utils/error_messages.dart';
import '../../view/utils/show_alerts.dart';
import '../../view/utils/show_snackbars.dart';

class DeleteAccountController extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String? email;
  final String password;
  const DeleteAccountController(
      {super.key,
      required this.formKey,
      required this.email,
      required this.password});

  @override
  State<DeleteAccountController> createState() =>
      _DeleteAccountControllerState();
}

class _DeleteAccountControllerState extends State<DeleteAccountController> {
  final userRepository = UserRepositoryImpl();

  _authenticateAndDelete() {
    onLoading();
    userRepository.login(widget.email!, widget.password).then((_) {
      ShowAlerts.openDecisiveDialog(
              context,
              '¿Desea proceder a eliminar la cuenta:${widget.email}?',
              const Icon(
                Icons.person_off_rounded,
                size: 36,
              ),
              Colors.red[900]!)
          .then((accept) {
        if (accept) {
          userRepository.deleteUser().then((_) {
            userRepository.logout().then((_) {
              studentPendingAdvicesList = [];
              studentCompletedAdvicesList = [];
              advisorPendingAdvicesList = [];
              advisorCompletedAdvicesList = [];
              advisorCanceledAdvicesList = [];
              advisorSubjectsList = [];
              userData = UserEntity();
              context.goNamed(LoginView.routeName);
              ShowSnackbars.openInformativeSnackBar(
                  context, "Cuenta Eliminada");
            });
          });
        }
      });
    }).catchError((error, stackTrace) {
      ShowAlerts.openErrorDialog(context, 'Error de autenticación!!',
          ErrorMessages.getAuthErrorMessage(error.message));
    }).whenComplete(() => offLoading());
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.red[900])),
      onPressed: () => {
        if (widget.formKey.currentState!.validate()) _authenticateAndDelete()
      },
      child: const Text('Borrar Cuenta',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  @override
  bool isLoading = false;

  @override
  void offLoading() {
    setState(() => isLoading = false);
  }

  @override
  void onLoading() {
    setState(() => isLoading = true);
  }
}
