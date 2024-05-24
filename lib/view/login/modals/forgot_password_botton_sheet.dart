import 'package:aspartec/controller/login/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/assets.dart';
import '../../utils/validations.dart';

class ForgotPasswordBottomSheet extends StatelessWidget {
  const ForgotPasswordBottomSheet({super.key});

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
          child: ForgotPasswordForm(),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _showModal(context),
      child: const Text('Olvidé mi contraseña'),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.keyboard_arrow_down_rounded),
          const SizedBox(height: 10),
          const Text(
            'Recuperación de contraseña',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            )
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400),
            child: SvgPicture.asset(Assets.picturesForgotPass),
          ),
          TextFormField(
            controller: _emailController,
            validator: FormValidations.emailValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Correo electrónico'),
              prefixIcon: Icon(Icons.email_rounded)
            )
          ),
          const SizedBox(height: 15),
          ForgotPasswordController(
            formKey: _formKey,
            emailController: _emailController
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}


