import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/implementation/user_repository_impl.dart';
import '../../view/utils/error_messages.dart';
import '../../view/utils/show_alerts.dart';
import '../utils/loading.dart';

class ForgotPasswordController extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  const ForgotPasswordController({
    super.key,
    required this.formKey,
    required this.emailController
  });

  @override
  State<ForgotPasswordController> createState() => _ForgotPasswordControllerState();
}

class _ForgotPasswordControllerState extends State<ForgotPasswordController> implements Loading {
  final userRepository = UserRepositoryImpl();

  void _sendEmail() async {
    onLoading();
    userRepository.sendEmailForReset(widget.emailController.text.trim())
        .then((_) => _back())
        .catchError((error, stackTrace) => _showError(error.message))
        .whenComplete(() => offLoading());
  }

  void _back() {
    context.pop();
  }

  void _showError(String code) {
    ShowAlerts.openErrorDialog(
        context, 
        'ERROR DE ENVIO', 
        ErrorMessages.getAuthErrorMessage(code)
    );
  }

  Widget _showButtonOrLoading() {
    return isLoading ? const CircularProgressIndicator() :
    FilledButton(
      onPressed: () {
        if (widget.formKey.currentState!.validate()) {
          _sendEmail();
        }
      },
      child: const Text('Enviar correo de recuperación'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _showButtonOrLoading();
  }

  @override
  bool isLoading = false;

  @override
  void offLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onLoading() {
    setState(() {
      isLoading = true;
    });
  }
}
