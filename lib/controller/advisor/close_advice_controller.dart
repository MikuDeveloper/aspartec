import 'dart:io';

import 'package:aspartec/globals.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/entities/advice_entity.dart';
import '../../model/implementation/advices_repository_impl.dart';
import '../../view/utils/show_alerts.dart';
import '../../view/utils/show_snackbars.dart';
import '../utils/loading.dart';

class CloseAdviceController extends StatefulWidget {
  final AdviceEntity advice;
  final File file;
  final int rating;
  final int index;
  const CloseAdviceController({
    super.key,
    required this.advice,
    required this.file,
    required this.rating,
    required this.index
  });

  @override
  State<CloseAdviceController> createState() => _CloseAdviceControllerState();
}

class _CloseAdviceControllerState extends State<CloseAdviceController> implements Loading {
  final adviceRepository = AdvicesRepositoryImpl();

  _closeAdvice() {
    if (widget.rating != 0) {
      _uploadFile();
    }
  }

  void _uploadFile() {
    final upload = adviceRepository.loadEvidence(widget.file, widget.advice.id!);
    upload.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          onLoading();
          break;
        case TaskState.paused:
          offLoading();
          break;
        case TaskState.success:
          _updateData(taskSnapshot.ref.fullPath);
          break;
        case TaskState.canceled:
          offLoading();
          break;
        case TaskState.error:
          _showError();
          offLoading();
          break;
      }
    });
  }

  _updateData(String path) {
    adviceRepository.getUrlFile(path)
    .then((url) {
      adviceRepository.closeAdvice(
          id: widget.advice.id!,
          rating: widget.rating,
          evidenceUrl: url
      ).then((_) => {
        advisorPendingAdvicesList.removeWhere((item) => item.id == widget.advice.id),
        advisorPendingAdvicesKey.currentState!.removeItem(
            widget.index,
            (context, animation) => _removeBuilder(context, animation)
        ),
        _back()
      })
          .catchError((error, stackTrace) => _showError())
          .whenComplete(() => offLoading());
    })
    .catchError((error, stackTrace) {
      _showError();
    });
  }

  _removeBuilder(context, animation) {
    return SlideTransition(
      position: animation.drive(
          Tween(begin: const Offset(1,0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.elasticInOut))
      ),
      child: const Card(color: Colors.greenAccent, child: ListTile())
    );
  }

  _back() {
    context.pop();
    ShowSnackbars.openInformativeSnackBar(context, 'Asesoría cerrada correctamente.');
  }

  _showError() {
    ShowAlerts.openErrorDialog(
      context,
      'ERROR',
      'Ocurrió un error al intentar cerrar la asesoría. Intente nuevamente.'
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
      ? const CircularProgressIndicator()
      : FilledButton(
        onPressed: _closeAdvice,
        child: const Text('Cerrar asesoría'),
      );
  }

  @override
  bool isLoading = false;

  @override
  void offLoading() {
    setState(() => isLoading = false);
  }

  @override
  void onLoading() {
    setState(() => isLoading = true);
  }
}
