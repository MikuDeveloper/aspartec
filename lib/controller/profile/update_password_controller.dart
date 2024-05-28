import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/implementation/user_repository_impl.dart';
import '../../view/utils/error_messages.dart';
import '../../view/utils/show_alerts.dart';
import '../../view/utils/show_snackbars.dart';
import '../utils/loading.dart';

class UpdatePasswordController extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String currentPassword;
  final String newPassword;
  const UpdatePasswordController({
    super.key,
    required this.formKey,
    required this.currentPassword,
    required this.newPassword
  });

  @override
  State<UpdatePasswordController> createState() => _UpdatePasswordControllerState();
}

class _UpdatePasswordControllerState extends State<UpdatePasswordController> implements Loading {
  final userRepository = UserRepositoryImpl();

  _authenticateAndUpdate() {
    onLoading();
    userRepository.updatePassword(widget.currentPassword, widget.newPassword)
    .then((_) {
      context.pop();
      ShowSnackbars.openInformativeSnackBar(context, 'Contraseña actualizada éxitosamente.');
    })
    .catchError((error, stackTrace) {
      ShowAlerts.openErrorDialog(
        context,
        'Error de actualización',
        ErrorMessages.getAuthErrorMessage(error.message)
      );
    })
    .whenComplete(() => offLoading());
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => {
        if (widget.formKey.currentState!.validate()) _authenticateAndUpdate()
      },
      child: const Text('Actualizar contraseña'),
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
