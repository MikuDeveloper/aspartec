import 'package:flutter/material.dart';

class RegisterBottomSheet extends StatelessWidget {
  const RegisterBottomSheet({super.key});

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
          child: RegisterForm(),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _showModal(context),
      child: const Text('Regístrate aquí.')
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.keyboard_arrow_down_rounded),
          const SizedBox(height: 10),
          const Text(
            'Formulario de registro',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          TextFormField()
        ],
      ),
    );
  }
}

