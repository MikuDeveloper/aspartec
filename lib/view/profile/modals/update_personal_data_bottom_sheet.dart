import 'package:aspartec/controller/profile/update_personal_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
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
                  left: 15),
              child:
                  const SingleChildScrollView(child: _UpdatePersonalDataForm()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: const Text('Datos Personales'),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () => _showModal(context),
    );
  }
}

class _UpdatePersonalDataForm extends StatefulWidget {
  const _UpdatePersonalDataForm();

  @override
  State<_UpdatePersonalDataForm> createState() =>
      _UpdatePersonalDataFormState();
}

class _UpdatePersonalDataFormState extends State<_UpdatePersonalDataForm> {
  final _formKey = GlobalKey<FormState>();

  late UserEntity _user = UserEntity();
  late bool _readOnly = true;

  @override
  void initState() {
    super.initState();
    _user = _user.copyWith(
        type: userData.type,
        firstname: userData.firstname,
        lastname1: userData.lastname1,
        lastname2: userData.lastname2,
        phoneNumber: userData.phoneNumber,
        gender: userData.gender,
        major: userData.major,
        controlNumber: userData.controlNumber,
        email: userData.email,
        photoUrl: userData.photoUrl);
  }

  void _edit() {
    setState(() => _readOnly = !_readOnly);
  }

  void _setName(String value) {
    setState(() {
      _user = _user.copyWith(firstname: value.trim());
    });
  }

  void _setLastname1(String value) {
    setState(() {
      _user = _user.copyWith(lastname1: value.trim());
    });
  }

  void _setLastname2(String value) {
    setState(() {
      _user = _user.copyWith(lastname2: value.trim());
    });
  }

  void _setPhone(String value) {
    setState(() {
      final rawPhone = toNumericString(value);
      //_user = _user.copyWith(phoneNumber: value.trim());
      _user = _user.copyWith(phoneNumber: rawPhone);

      //_phoneFormatted =
      //    '(${_user.phoneNumber?.substring(0, 3)}) ${_user.phoneNumber?.substring(3, 6)}-${_user.phoneNumber?.substring(6, 10)}';
    });
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
          const Text('Datos Personales',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              ]),
          const SizedBox(height: 10),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Nombre(s)'),
                prefixIcon: Icon(Icons.short_text_rounded)),
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
                label: Text('Apellido Paterno'),
                prefixIcon: Icon(Icons.short_text_rounded)),
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
                label: Text('Apellido Materno'),
                prefixIcon: Icon(Icons.short_text_rounded)),
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
                prefixIcon: Icon(Icons.phone_rounded)),
            inputFormatters: [
              MaskedInputFormatter('(###) ###-####'),
            ],
            onChanged: _setPhone,
            initialValue: _user.phoneNumber,
            //initialValue: _formatPhoneNumber(_user.phoneNumber),
            //initialValue:
            //    '(${_user.phoneNumber?.substring(0, 3)}) ${_user.phoneNumber?.substring(3, 6)}-${_user.phoneNumber?.substring(6, 10)}',
            //initialValue: toFormattedPhoneNumber(_user.phoneNumber!),
            readOnly: _readOnly,
          ),
          const SizedBox(height: 15),
          Consumer(
            builder: (context, ref, _) => DropdownMenu(
              dropdownMenuEntries: genderList
                  .map((item) => DropdownMenuEntry(value: item, label: item))
                  .toList(),
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
          UpdatePersonalController(formKey: _formKey, user: _user),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

String toNumericString(String value) {
  return value.replaceAll(RegExp(r'[^0-9]'), '');
}

// String toFormattedPhoneNumber(String value) {
//   String phoneX =
//       '(${value.substring(0, 3)}) ${value.substring(3, 6)}-${value.substring(6, 10)}';
//   return phoneX;
// }
