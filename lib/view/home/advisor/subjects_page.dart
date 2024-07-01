import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../globals.dart';
import '../../../model/implementation/subjects_respository_impl.dart';
import '../../utils/show_alerts.dart';
import '../../utils/show_snackbars.dart';

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});

  _removeItem(context, int index, String id) {
    advisorSubjectsList.removeWhere((item) => item.id == id);
    advisorSubjectsKey.currentState!.removeItem(
        index, (context, animation) => SlideTransition(
        position: animation.drive(
            Tween(begin: const Offset(1,0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.decelerate))
        ),
        child: const Card(color: Colors.red, child: ListTile())
      )
    );
  }

  Future<void> _delete(context, int index, String id) async {
    final accept = await ShowAlerts.openDecisiveDialog(
        context,
        '¿Desea eliminar el registro de la Materia?',
        const Icon(Icons.delete_outline_rounded),
        Colors.redAccent
    );
    if (accept) {
      final subjectRepository = SubjectsRepositoryImpl();
      try {
        await subjectRepository.deleteSubject(id);
        ShowSnackbars.openInformativeSnackBar(context, 'Registro de materia eliminado.');
        _removeItem(context, index, id);
      } catch (_) {
        _showError(context);
      }
    }
  }

  _showError(context) {
    ShowAlerts.openErrorDialog(
      context,
      'ERROR DE ELIMINACÓN',
      'Ocurrió un error al intentar eliminar el registro, vuelva a intentarlo.'
    );
  }

  Widget _builder(context, index, animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Card(
          child: ListTile(
            title: Text(
              advisorSubjectsList[index].subjectName!,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.ptSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: const Icon(Icons.folder_open,
              size: 20,
            ),
            trailing: IconButton(
              onPressed: () => _delete(context, index, advisorSubjectsList[index].id!),
              icon: const Icon(Icons.delete,
                color: Colors.red,
                size: 20,
              ),
            )
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: advisorSubjectsKey,
      initialItemCount: advisorSubjectsList.length,
      itemBuilder: _builder,
    );
  }
}
