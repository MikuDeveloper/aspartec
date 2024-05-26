import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/student/advice_register_controller.dart';
import '../../../globals.dart';
import '../../../model/entities/advice_entity.dart';
import '../../../model/entities/subject_entity.dart';
import '../../../model/implementation/subjects_respository_impl.dart';
import '../../../providers/error_provider.dart';
import '../../utils/form_values.dart';
import '../../utils/validations.dart';

class RequestAdviceBottomSheet extends StatelessWidget {
  const RequestAdviceBottomSheet({super.key});

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
        child: const SingleChildScrollView(
          child: RequestAdviceForm(),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showModal(context),
      label: const Text('Solicitar'),
      icon: const Icon(Icons.add_rounded)
    );
  }
}

class RequestAdviceForm extends StatefulWidget {
  const RequestAdviceForm({super.key});

  @override
  State<RequestAdviceForm> createState() => _RequestAdviceFormState();
}

class _RequestAdviceFormState extends State<RequestAdviceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _advisorController = TextEditingController();
  final subjectsRepository = SubjectsRepositoryImpl();
  late List<SubjectEntity> subjects = [];
  late List<SubjectEntity> advisors = [];
  late List<String> pending = [];
  late AdviceEntity newAdvice = AdviceEntity();

  @override
  void initState() {
    super.initState();
    final date = DateTime.now();

    final docRef = FirebaseFirestore.instance.collection('asesorias').doc();

    newAdvice = newAdvice.copyWith(
      id: docRef.id,
      studentControlNumber: userData.controlNumber,
      studentMajor: userData.major,
      studentName: '${userData.firstname} ${userData.lastname1} ${userData.lastname2 ?? ''}'.trim(),
      studentPhoneNumber: userData.phoneNumber,
      adviceDate: '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
      adviceStatus: 'Abierta',
      adviceAdvisorRating: 0,
      adviceStudentRating: 0
    );

    setState(() {
      pending = studentPendingAdvicesList.map((item) => item.adviceSubjectName!).toList();
    });

    subjectsRepository.getSubjectsForStudent(userData.email!)
    .then((list) {
      setState(() {
        subjects = list;
      });
    });
  }

  _setSubject(String? value, WidgetRef ref) {
    setState(() {
      newAdvice = newAdvice.copyWith(adviceSubjectName: value);
      advisors = subjects.where((item) => item.subjectName == value && !pending.contains(value)).toList();
      ref.read(registerSubjectError.notifier).state = null;
      _advisorController.clear();
    });
  }

  _setTopic(String value) => setState(() {
    newAdvice = newAdvice.copyWith(adviceTopicName: value);
  });

  _setAdvisor(String? value, WidgetRef ref) {
    setState(() {
      final advisor = advisors.singleWhere((item) => item.advisorControlNumber == value);
      newAdvice = newAdvice.copyWith(
        advisorName: advisor.advisorName,
        advisorControlNumber: advisor.advisorControlNumber,
        advisorMajor: advisor.advisorMajor,
        advisorPhoneNumber: advisor.advisorPhoneNumber,
      );
      ref.read(advisorError.notifier).state = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.keyboard_arrow_down_rounded),
          const SizedBox(height: 10),
          const Text(
            'Solicitud de asesoría',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 20),
          Consumer(
            builder: (context, ref, _) => DropdownMenu(
              dropdownMenuEntries: subjectsList.map(
                (item) => DropdownMenuEntry(value: item, label: item)
              ).toList(),
              label: const Text('Materia'),
              leadingIcon: const Icon(Icons.collections_bookmark),
              expandedInsets: EdgeInsets.zero,
              errorText: ref.watch(registerSubjectError),
              onSelected: (value) => _setSubject(value, ref),
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Tema'),
              prefixIcon: Icon(Icons.short_text_rounded)
            ),
            onChanged: _setTopic,
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 15),
          Consumer(
            builder: (context, ref, _) => DropdownMenu(
              controller: _advisorController,
              dropdownMenuEntries: advisors.map(
                (item) => DropdownMenuEntry(
                  value: item.advisorControlNumber,
                  label: item.advisorName!,
                  //enabled: !pending.contains(item.advisorControlNumber)
                )
              ).toList(),
              label: const Text('Asesor'),
              leadingIcon: const Icon(Icons.supervised_user_circle_rounded),
              expandedInsets: EdgeInsets.zero,
              errorText: ref.watch(advisorError),
              onSelected: (value) => _setAdvisor(value, ref),
            ),
          ),
          const SizedBox(height: 30),
          AdviceRegisterController(formKey: _formKey, advice: newAdvice),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

