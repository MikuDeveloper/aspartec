import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../globals.dart';
import '../../model/entities/subject_entity.dart';
import '../../model/implementation/subjects_respository_impl.dart';
import '../../providers/error_provider.dart';
import '../../view/utils/show_alerts.dart';
import '../utils/loading.dart';

class SubjectsRegisterController extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final SubjectEntity subject;
  const SubjectsRegisterController({super.key, required this.formKey, required this.subject});

  @override
  State<SubjectsRegisterController> createState() => _SubjectsRegisterControllerState();
}

class _SubjectsRegisterControllerState extends State<SubjectsRegisterController> implements Loading {
  final subjectsRepository = SubjectsRepositoryImpl();

  void _registerSubject(WidgetRef ref) {
    if (widget.formKey.currentState!.validate() && widget.subject.subjectName != null) {
      onLoading();
      subjectsRepository.registerSubject(widget.subject)
      .then((_) {
        final length = advisorSubjectsList.length;
        advisorSubjectsList.add(widget.subject);
        advisorSubjectsKey.currentState!.insertItem(length);
        context.pop();
      })
      .catchError((error, stackTrace) {
        _showAlert(error.message);
      })
      .whenComplete(() => offLoading());
    }

    if (widget.subject.subjectName == null) {
      ref.read(subjectError.notifier).state = 'Selecciona una materia de la lista';
    }
  }
  
  void _showAlert(String error) {
    ShowAlerts.openErrorDialog(
      context, 
      'Error de registro',
      'Ha ocurrido un error al registrar la materia. Vuelva a intentarlo.'
    );
  }

  Widget _setButtonOrLoading(WidgetRef ref) {
    return (isLoading)
        ? const CircularProgressIndicator()
        : FilledButton(
        onPressed: () => _registerSubject(ref),
        child: const Text('Registrar')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) => _setButtonOrLoading(ref),
    );
  }

  @override
  bool isLoading = false;

  @override
  void offLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onLoading() {
    setState(() {
      isLoading = true;
    });
  }
}
