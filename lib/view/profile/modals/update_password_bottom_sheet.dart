import 'package:flutter/material.dart';

import '../../../controller/profile/update_password_controller.dart';
import '../../utils/validations.dart';

class UpdatePasswordBottomSheet extends StatelessWidget {
  const UpdatePasswordBottomSheet({super.key});

  _showModal(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: false,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          top: 30,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 15
        ),
        child: const SingleChildScrollView(child: _UpdatePasswordForm()),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.key_rounded),
      title: const Text('Cambiar contraseña'),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () => { _showModal(context) },
    );
  }
}

class _UpdatePasswordForm extends StatefulWidget {
  const _UpdatePasswordForm();

  @override
  State<_UpdatePasswordForm> createState() => _UpdatePasswordFormState();
}

class _UpdatePasswordFormState extends State<_UpdatePasswordForm> {
  final _formKey = GlobalKey<FormState>();

  late String _currentPassword = '';
  late String _newPassword = '';

  late bool _obscureText = true;

  _toggleObscureText() => setState(() => _obscureText = !_obscureText);

  _setCurrentPassword(String value) => setState(() => _currentPassword = value);
  _setNewPassword(String value) => setState(() => _newPassword = value);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Icon(Icons.keyboard_arrow_down_rounded),
          const SizedBox(height: 10),
          const Text(
              'Cambio de contraseña',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 25),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscureText,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Contraseña actual',
              prefixIcon: const Icon(Icons.key_rounded),
              suffixIcon: IconButton(
                onPressed: _toggleObscureText,
                icon: _obscureText
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility)
              )
            ),
            onChanged: _setCurrentPassword,
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: FormValidations.passwordValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscureText,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Nueva contraseña',
              prefixIcon: const Icon(Icons.key_rounded),
              suffixIcon: IconButton(
                onPressed: _toggleObscureText,
                icon: _obscureText
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility)
              )
            ),
            onChanged: _setNewPassword,
          ),
          const SizedBox(height: 30),
          UpdatePasswordController(
            formKey: _formKey,
            currentPassword: _currentPassword,
            newPassword: _newPassword
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}

