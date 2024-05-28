import 'package:aspartec/providers/error_provider.dart';
import 'package:aspartec/view/utils/form_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/login/register_controller.dart';
import '../../../model/entities/user_entity.dart';
import '../../utils/validations.dart';

class RegisterBottomSheet extends StatelessWidget {
  const RegisterBottomSheet({super.key});

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

enum UserType { student, advisor }

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  late bool _obscureText = true;
  late UserType _userType = UserType.student;
  late UserEntity _user = UserEntity(type: _userType.name);
  late String _pass = '';

  void _setType (UserType? value) {
    setState(() {
      _userType = value!;
      _user = _user.copyWith(type: value.name);
    });
  }

  void _setName(String value) {
    setState(() { _user = _user.copyWith(firstname: value.trim()); });
  }

  void _setLastname1(String value) {
    setState(() { _user = _user.copyWith(lastname1: value.trim()); });
  }

  void _setLastname2(String value) {
    setState(() { _user = _user.copyWith(lastname2: value.trim()); });
  }

  void _setPhone(String value) {
    setState(() { _user = _user.copyWith(phoneNumber: value.trim()); });
  }

  void _setGender(String? value, WidgetRef ref) {
    setState(() {
      _user = _user.copyWith(gender: value);
      ref.read(genderError.notifier).state = null;
    });
  }

  void _setControlNumber(String value) {
    setState(() { _user = _user.copyWith(controlNumber: value.trim()); });
  }

  void _setMajor(String? value, WidgetRef ref) {
    setState(() {
      _user = _user.copyWith(major: value);
      ref.read(majorError.notifier).state = null;
    });
  }

  void _setEmail(String value) {
    setState(() { _user = _user.copyWith(email: value.trim()); });
  }

  void _setPassword(String value) {
    setState(() { _pass = value; });
  }

  void _toggleObscureText() {
    setState(() { _obscureText = !_obscureText; });
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
            'Formulario de registro',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),

          /********************************************************************/
          const SizedBox(height: 15),
          const Text('Perfil'),
          const Divider(),
          RadioListTile(
            title: const Text('Estudiante'),
            value: UserType.student,
            groupValue: _userType,
            onChanged: _setType
          ),
          RadioListTile(
            title: const Text('Asesor'),
            value: UserType.advisor,
            groupValue: _userType,
            onChanged: _setType
          ),

          /********************************************************************/
          const Text('Datos personales'),
          const Divider(),
          const SizedBox(height: 10),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Nombre(s)'),
              prefixIcon: Icon(Icons.short_text_rounded)
            ),
            onChanged: _setName,
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Primer apellido'),
              prefixIcon: Icon(Icons.short_text_rounded)
            ),
            onChanged: _setLastname1,
          ),
          const SizedBox(height: 15),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Segundo apellido'),
              prefixIcon: Icon(Icons.short_text_rounded)
            ),
            onChanged: _setLastname2,
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: FormValidations.phoneNumberValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Teléfono'),
              prefixIcon: Icon(Icons.phone_rounded)
            ),
            onChanged: _setPhone,
          ),
          const SizedBox(height: 15),
          Consumer(builder: (context, ref, _) =>
            DropdownMenu(
              dropdownMenuEntries: genderList.map(
                (item) => DropdownMenuEntry(value: item, label: item)
              ).toList(),
              leadingIcon: const Icon(Icons.transgender_rounded),
              expandedInsets: EdgeInsets.zero,
              label: const Text('Género'),
              errorText: ref.watch(genderError),
              onSelected: (value) => _setGender(value, ref),
            ),
          ),

          /********************************************************************/
          const SizedBox(height: 20),
          const Text('Datos de escolares'),
          const Divider(),
          const SizedBox(height: 10),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Número de control'),
              prefixIcon: Icon(Icons.person_search_rounded)
            ),
            onChanged: _setControlNumber,
          ),
          const SizedBox(height: 15),
          Consumer(builder: (context, ref, _) =>
            DropdownMenu(
              dropdownMenuEntries: majorList.map(
                (item) => DropdownMenuEntry(value: item, label: item)
              ).toList(),
              leadingIcon: const Icon(Icons.menu_book),
              expandedInsets: EdgeInsets.zero,
              label: const Text('Programa educativo'),
              errorText: ref.watch(majorError),
              onSelected: (value) => _setMajor(value, ref),
            ),
          ),

          /********************************************************************/
          const SizedBox(height: 20),
          const Text('Datos de acceso'),
          const Divider(),
          const SizedBox(height: 10),
          TextFormField(
            validator: FormValidations.emailValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Correo electrónico'),
              prefixIcon: Icon(Icons.email_rounded)
            ),
            onChanged: _setEmail,
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: FormValidations.passwordValidation,
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
            ),
            onChanged: _setPassword,
          ),
          const SizedBox(height: 30),
          RegisterController(formKey: _formKey, user: _user, pass: _pass),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
