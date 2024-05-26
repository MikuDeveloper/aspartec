import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controller/advisor/subjects_register_controller.dart';
import '../../../../model/entities/subject_entity.dart';
import '../../../../model/entities/user_entity.dart';
import '../../../../providers/error_provider.dart';
import '../../../../providers/subjects_provider.dart';
import '../../../utils/validations.dart';

class SubjectRegisterBottomSheet extends StatelessWidget {
  final UserEntity user;
  const SubjectRegisterBottomSheet({super.key, required this.user});

  _showModal(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          top: 30,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 15
        ),
        child: SingleChildScrollView(
          child: _SubjectRegisterForm(user: user),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        _showModal(context);
      },
      label: const Text('Registrar'),
      icon: const Icon(Icons.collections_bookmark_outlined),
    );
  }
}

class _SubjectRegisterForm extends StatefulWidget {
  final UserEntity user;
  const _SubjectRegisterForm({required this.user});

  @override
  State<_SubjectRegisterForm> createState() => _SubjectRegisterFormState();
}

class _SubjectRegisterFormState extends State<_SubjectRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  late SubjectEntity _subject = SubjectEntity();
  late UserEntity user;

  @override
  void initState() {
    final docRef = FirebaseFirestore.instance.collection('materias').doc();
    user = widget.user;
    _subject = _subject.copyWith(
      id: docRef.id,
      advisorControlNumber: user.controlNumber,
      advisorMajor: user.major,
      advisorName: '${user.firstname} ${user.lastname1} ${user.lastname2 ?? ''}'.trim(),
      advisorPhoneNumber: user.phoneNumber,
      advisorEmail: user.email
    );
    super.initState();
  }

  void _setSubject(String? value, WidgetRef ref) {
    setState(() {
      _subject = _subject.copyWith(subjectName: value);
      ref.read(subjectError.notifier).state = null;
    });
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
            'Registro de materia',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 25),
          Consumer(
            builder: (context, ref, _) {
              return DropdownMenu(
                dropdownMenuEntries: ref.watch(subjectsEntries),
                label: const Text('Materia'),
                leadingIcon: const Icon(Icons.book_rounded),
                expandedInsets: EdgeInsets.zero,
                errorText: ref.watch(subjectError),
                onSelected: (value) => _setSubject(value, ref),
              );
            }
          ),
          const SizedBox(height: 25),
          const Text('Mis datos de asesor'),
          const Divider(),
          const SizedBox(height: 20),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Número de control'),
              prefixIcon: Icon(Icons.person_search_rounded)
            ),
            readOnly: true,
            initialValue: _subject.advisorControlNumber,
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Programa educativo'),
              prefixIcon: Icon(Icons.menu_book)
            ),
            readOnly: true,
            initialValue: _subject.advisorMajor,
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Nombre'),
              prefixIcon: Icon(Icons.short_text_rounded)
            ),
            readOnly: true,
            initialValue: _subject.advisorName,
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Teléfono'),
              prefixIcon: Icon(Icons.phone_rounded)
            ),
            readOnly: true,
            initialValue: _subject.advisorPhoneNumber,
          ),
          const SizedBox(height: 25),
          SubjectsRegisterController(formKey: _formKey, subject: _subject),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

