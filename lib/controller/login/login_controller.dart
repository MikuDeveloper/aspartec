import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/implementation/user_repository_impl.dart';
import '../../view/home/home_view.dart';
import '../../view/utils/error_messages.dart';
import '../../view/utils/show_alerts.dart';
import '../utils/loading.dart';

class LoginController extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginController({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController
  });

  @override
  State<LoginController> createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> implements Loading {
  final userRepository = UserRepositoryImpl();

  void _login () {
    onLoading();
    userRepository.login(
      widget.emailController.text.trim(),
      widget.passwordController.text
    ).then((_) => _goToHome())
    .catchError((error, stackTrace) => _showError(error.message))
    .whenComplete(() => offLoading());
  }

  void _goToHome() {
    context.goNamed(HomeView.routeName);
  }

  void _showError(String code) {
    ShowAlerts.openErrorDialog(
        context,
        'Error de inicio de sesión',
        ErrorMessages.getAuthErrorMessage(code)
    );
  }

  Widget _showButtonOrLoading() {
    return isLoading ? const CircularProgressIndicator() :
      FilledButton(
        onPressed: () {
          if (widget.formKey.currentState!.validate()) {
            _login();
          }
        },
        child: const Text('Ingresar'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return _showButtonOrLoading();
  }

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

  @override
  late bool isLoading = false;
}
