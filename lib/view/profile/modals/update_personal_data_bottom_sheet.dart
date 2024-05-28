import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../globals.dart';
import '../../../model/entities/user_entity.dart';
import '../../../providers/error_provider.dart';
import '../../utils/form_values.dart';
import '../../utils/validations.dart';

class UpdatePersonalDataBottomSheet extends StatelessWidget {
  const UpdatePersonalDataBottomSheet({super.key});

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
        child: const SingleChildScrollView(child: _UpdatePersonalDataForm()),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: const Text('Datos personales'),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () => _showModal(context),
    );
  }
}

class _UpdatePersonalDataForm extends StatefulWidget {
  const _UpdatePersonalDataForm();

  @override
  State<_UpdatePersonalDataForm> createState() => _UpdatePersonalDataFormState();
}

class _UpdatePersonalDataFormState extends State<_UpdatePersonalDataForm> {
  final _formKey = GlobalKey<FormState>();

  late UserEntity _user = UserEntity();
  late bool _readOnly = true;

  @override
  void initState() {
    super.initState();
    _user = _user.copyWith(
      firstname: userData.firstname,
      lastname1: userData.lastname1,
      lastname2: userData.lastname2,
      phoneNumber: userData.phoneNumber,
      gender: userData.gender
    );
  }

  void _edit() {
    setState(() => _readOnly = !_readOnly);
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Icon(Icons.keyboard_arrow_down_rounded),
          const SizedBox(height: 10),
          const Text(
            'Datos personales',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton.outlined(
                onPressed: _edit,
                icon: const Icon(Icons.edit_off_rounded),
                selectedIcon: const Icon(Icons.edit_rounded),
                isSelected: !_readOnly,
              )
            ]
          ),
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
            initialValue: _user.firstname,
            readOnly: _readOnly,
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
            initialValue: _user.lastname1,
            readOnly: _readOnly,
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
            initialValue: _user.lastname2,
            readOnly: _readOnly,
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
            initialValue: _user.phoneNumber,
            readOnly: _readOnly,
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
              initialSelection: _user.gender,
              enabled: !_readOnly,
            ),
          ),
          const SizedBox(height: 30),
          //TODO: Implement controller
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

