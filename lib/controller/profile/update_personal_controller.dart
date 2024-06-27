import 'package:aspartec/model/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/implementation/user_repository_impl.dart';
import '../../view/utils/error_messages.dart';
import '../../view/utils/show_alerts.dart';
import '../../view/utils/show_snackbars.dart';
import '../utils/loading.dart';

class UpdatePersonalController extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final UserEntity user;
  const UpdatePersonalController(
      {super.key,
      required this.formKey,
      required this.user});

  @override
  State<UpdatePersonalController> createState() =>
      _UpdatePersonalControllerState();
}

class _UpdatePersonalControllerState extends State<UpdatePersonalController>
    implements Loading {
  final userRepository = UserRepositoryImpl();

  _updatePersonalData() {
    onLoading();
    //userRepository.updatePassword(widget.currentPassword, widget.newPassword)
    userRepository.registerOrUpdateData(widget.user).then((_) {
      context.pop();
      ShowSnackbars.openInformativeSnackBar(
          context, 'Datos actualizados éxitosamente.');
    }).catchError((error, stackTrace) {
      ShowAlerts.openErrorDialog(context, 'Error de actualización',
          ErrorMessages.getAuthErrorMessage(error.message));
    }).whenComplete(() => offLoading());
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => {
        if (widget.formKey.currentState!.validate()) _updatePersonalData()
      },
      child: const Text('Actualizar'),
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
