import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../view/home/home_view.dart';
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
  final auth = FirebaseAuth.instance;

  void _login () async {
    try {
      onLoading();
      await auth.signInWithEmailAndPassword(
        email: widget.emailController.text.trim(),
        password: widget.passwordController.text
      );
      offLoading();
      _goToHome();
    } on FirebaseAuthException catch (e) {
      offLoading();
      _showError(e.code);
    }
  }

  void _goToHome() {
    context.goNamed(HomeView.routeName);
  }

  void _showError(String code) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(code),
      )
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
