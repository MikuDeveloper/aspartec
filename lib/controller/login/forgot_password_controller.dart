import 'package:aspartec/controller/utils/loading.dart';
import 'package:aspartec/view/utils/show_alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  final auth = FirebaseAuth.instance;

  void _sendEmail() async {
    try {
      onLoading();
      await auth.sendPasswordResetEmail(email: widget.emailController.text.trim());
      offLoading();
      _back();
    } on FirebaseAuthException catch (e) {
      offLoading();
      _showError(e.code);
    }
  }

  void _back() {
    context.pop();
  }

  void _showError(String code) {
    ShowAlerts.openErrorDialog(context, 'ERROR DE ENVIO', code);
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
