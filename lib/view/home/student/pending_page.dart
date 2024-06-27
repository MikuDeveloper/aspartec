import 'package:aspartec/view/utils/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../globals.dart';
import '../../../model/implementation/advices_repository_impl.dart';
import '../../utils/lauchers.dart';
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
          Tween(begin: const Offset(1,0), end: Offset.zero)
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
      ErrorMessages.getFirestoreErrorMessage(error.message)
    );
  }

  _openWhatsApp(context, String numberPhone) {
    Launchers.openWhatsApp(context: context, phoneNumber: numberPhone);
  }

  Widget _builder(context, index, animation) {
    final subject = studentPendingAdvicesList[index].adviceSubjectName!;
    final topic = studentPendingAdvicesList[index].adviceTopicName!;
    final advisor = studentPendingAdvicesList[index].advisorName!;
    final advisorPhone = studentPendingAdvicesList[index].advisorPhoneNumber!;
    final subtitle = 'Tema: $topic\nAsesor: $advisor';

    return SizeTransition(
      sizeFactor: animation,
      child: Dismissible(
        key: Key(advisorPhone),
        direction: DismissDirection.startToEnd,
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color(0xFF25D366),
          child: const ImageIcon(
            AssetImage("assets/icon/whatsapp.png"),
            color: Colors.white,
          ),
        ),
        confirmDismiss: (direction) async {
          bool? result = await _openWhatsApp(context, advisorPhone);
          return result ?? false;  // Ensure a boolean is returned
        },
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text(subject,
                  style: GoogleFonts.ptSans(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: Expanded(
                  child: Text(subtitle,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.ptSans(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                leading: const Icon(Icons.pending_actions_rounded,
                  size: 28,
                ),
                trailing: Column(
                  children: [
                    IconButton(
                      onPressed: () => _cancelAdvice(context, studentPendingAdvicesList[index].id!, index),
                      icon: const Icon(Icons.highlight_remove_rounded,
                        size: 28,
                        color: Colors.redAccent,
                      ),
                    ),
                  ]  
                ),
              ),
            ],
          )
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
