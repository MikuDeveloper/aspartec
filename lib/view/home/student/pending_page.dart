import 'package:flutter/material.dart';

import '../../../globals.dart';
import '../../../model/implementation/advices_repository_impl.dart';
import '../../utils/show_alerts.dart';
import '../../utils/show_snackbars.dart';

class PendingPage extends StatelessWidget {
  const PendingPage({super.key});

  Future<void> _cancelAdvice(BuildContext context, String id, int index) async {
    final accept = await ShowAlerts.openDecisiveDialog(
        context,
        '¿Desea cancelar la asesoría?',
        const Icon(Icons.free_cancellation_rounded),
        Colors.redAccent
    );

    if (accept) {
      final advicesRepository = AdvicesRepositoryImpl();
      advicesRepository.cancelAdvice(id)
      .then((_) => _removeItem(context, index, id))
      .catchError((error, stackTrace) => _showError(context, error, stackTrace));
    }
  }

  _removeItem(BuildContext context, int index, String id) {
    studentPendingAdvicesList.removeWhere((item) => item.id == id);
    studentPendingAdvicesKey.currentState!.removeItem(index,
      (context, animation) => SlideTransition(
        position: animation.drive(
          Tween(begin: const Offset(1,0), end: Offset.zero,)
              .chain(CurveTween(curve: Curves.decelerate))
        ),
        child: const Card(color: Colors.red, child: ListTile())
      )
    );
    ShowSnackbars.openInformativeSnackBar(context, 'Asesoría cancelada');
  }

  _showError(context, error, stackTrace) {
    ShowAlerts.openErrorDialog(
      context,
      'ERROR DE CANCELACIÓN',
      'Ocurrió un error al intentar cancelar la asesoría, inténtelo de nuevo.'
    );
  }


  Widget _builder(context, index, animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(studentPendingAdvicesList[index].adviceSubjectName!),
          subtitle: Text(studentPendingAdvicesList[index].adviceTopicName!),
          trailing: IconButton(
            onPressed: () => _cancelAdvice(context, studentPendingAdvicesList[index].id!, index),
            icon: const Icon(Icons.highlight_remove_rounded)
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: studentPendingAdvicesKey,
      initialItemCount: studentPendingAdvicesList.length,
      itemBuilder: _builder,
    );
  }
}
