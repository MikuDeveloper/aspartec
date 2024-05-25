import 'package:aspartec/controller/login/login_controller.dart';
import 'package:aspartec/view/login/modals/forgot_password_botton_sheet.dart';
import 'package:aspartec/view/login/modals/register_bottom_sheet.dart';
import 'package:aspartec/view/utils/validations.dart';
import 'package:flutter/material.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({super.key});

  _showModal(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          top: 30,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 15
        ),
        child: const SingleChildScrollView(
          child: LoginForm(),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => _showModal(context),
      child: const Text('Iniciar sesión'),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late bool _obscureText = true;

  _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.keyboard_arrow_down_rounded),
          const SizedBox(height: 10),
          const Text(
            'Inicio de sesión',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 25),
          TextFormField(
            controller: _emailController,
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Correo electrónico'),
              prefixIcon: Icon(Icons.email_rounded)
            )
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscureText,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Contraseña',
              prefixIcon: const Icon(Icons.key_rounded),
              suffixIcon: IconButton(
                onPressed: _toggleObscureText,
                icon: _obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility)
              )
            )
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ForgotPasswordBottomSheet(),
            ],
          ),
          const SizedBox(height: 10),
          LoginController(
            formKey: _loginFormKey,
            emailController: _emailController,
            passwordController: _emailController
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿No tienes cuenta?'),
              RegisterBottomSheet()
            ],
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}

