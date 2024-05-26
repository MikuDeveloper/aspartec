import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../globals.dart';
import '../../model/entities/advice_entity.dart';
import '../../model/implementation/advices_repository_impl.dart';
import '../../providers/error_provider.dart';
import '../../view/utils/show_alerts.dart';
import '../../view/utils/show_snackbars.dart';
import '../utils/loading.dart';

class AdviceRegisterController extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final AdviceEntity advice;
  const AdviceRegisterController({super.key, required this.formKey, required this.advice});

  @override
  State<AdviceRegisterController> createState() => _AdviceRegisterControllerState();
}

class _AdviceRegisterControllerState extends State<AdviceRegisterController> implements Loading {
  final adviceRepository = AdvicesRepositoryImpl();

  _addItem() {
    final length = studentPendingAdvicesList.length;
    studentPendingAdvicesList.add(widget.advice);
    studentPendingAdvicesKey.currentState!.insertItem(length);
  }

  _register() {
    onLoading();
    adviceRepository.registerAdvice(widget.advice)
    .then((_) {
      _addItem();
      context.pop();
      ShowSnackbars.openInformativeSnackBar(context, 'Asesoría registrada.');
    })
    .catchError((error, stackTrace) {
      ShowAlerts.openErrorDialog(
        context, 'ERROR DE REGISTRO',
        'Ocurrió un error al registrar la asesoría, vuelva a intentarlo.'
      );
    })
    .whenComplete(() => offLoading());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) => (isLoading)
      ? const CircularProgressIndicator()
      : FilledButton(
        onPressed: () {
          if (widget.formKey.currentState!.validate()) {
            _register();
          }

          if (widget.advice.adviceSubjectName == null) {
            ref.read(registerSubjectError.notifier).state = 'Seleccione una materia de la lista';
          }

          if (widget.advice.advisorName == null) {
            ref.read(advisorError.notifier).state = 'Seleccione un asesor de la lista';
          }
        },
        child: const Text('Solicitar'),
      ),
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
