import 'package:aspartec/model/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import '../../../globals.dart';
import '../../utils/validations.dart';
import 'modals.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet({super.key});

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
              child: const SingleChildScrollView(child: _PersonalData()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person_off_rounded),
      title: const Text('Borrar Cuenta'),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () => _showModal(context),
    );
  }
}

class _PersonalData extends StatefulWidget {
  const _PersonalData();

  @override
  State<_PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<_PersonalData> {
  final _formKey = GlobalKey<FormState>();

  late UserEntity _user = UserEntity();
  var userName = "";

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

  @override
  Widget build(BuildContext context) {

    
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Icon(Icons.keyboard_arrow_down_rounded),
          const SizedBox(height: 10),
          const Text('Borrar Cuenta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Cuenta'),
                prefixIcon: Icon(Icons.email_outlined,size: 18,)),
            initialValue: _user.email,
            readOnly: true,
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Nombre'),
                prefixIcon: Icon(Icons.person_outline,size: 18,)),
            initialValue: "${_user.firstname} ${_user.lastname1} ${_user.lastname2}",
            readOnly: true,
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: FormValidations.phoneNumberValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Teléfono'),
                prefixIcon: Icon(Icons.phone_rounded,size: 18,)),
            inputFormatters: [
              MaskedInputFormatter('(###) ###-####'),
            ],
            initialValue: toFormattedPhoneNumber(_user.phoneNumber!),
            readOnly: true,
          ),
          const SizedBox(height: 150),
        ],
      ),
    );
  }
}

String toFormattedPhoneNumber(String value) {
  String phoneX =
      '(${value.substring(0, 3)}) ${value.substring(3, 6)}-${value.substring(6, 10)}';
  return phoneX;
}

