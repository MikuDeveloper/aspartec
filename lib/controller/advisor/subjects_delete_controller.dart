import 'package:aspartec/providers/subjects_provider.dart';
import 'package:aspartec/view/utils/show_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/implementation/subjects_respository_impl.dart';
import '../../view/utils/list_keys.dart';
import '../../view/utils/show_alerts.dart';

class SubjectsDeleteController extends StatefulWidget {
  final String id;
  final int index;
  const SubjectsDeleteController({super.key, required this.id, required this.index});

  @override
  State<SubjectsDeleteController> createState() => _SubjectsDeleteControllerState();
}

class _SubjectsDeleteControllerState extends State<SubjectsDeleteController> {
  final subjectsRepository = SubjectsRepositoryImpl();

  late bool enabled = true;

  Future<void> _delete(WidgetRef ref) async {
    _disable();
    final accept = await ShowAlerts.openDecisiveDialog(
        context,
        '¿Desea eliminar el registro de la materia? Los estudiantes ya no podrán solicilarte asesorías.',
        const Icon(Icons.delete_forever),
        Colors.redAccent
    );

    if (accept) {
      subjectsRepository.deleteSubject(widget.id)
      .then((_) {
        _removeItem(ref);
        ShowSnackbars.openInformativeSnackBar(context, 'Materia eliminada.');
      })
      .catchError((error, stackTrace) {
        _showError(error, stackTrace);
      })
      .whenComplete(() => _enable());
    } else {
      _enable();
    }
  }

  _removeItem(WidgetRef ref) {
    ref.read(subjectsProvider.notifier).subjects.removeWhere((element) => element.id == widget.id);
    subjectsKey.currentState!.removeItem(widget.index,
      (context, animation) => SlideTransition(
        position: animation.drive(
          Tween(begin: const Offset(1,0), end: Offset.zero,)
              .chain(CurveTween(curve: Curves.decelerate))
        ),
        child: const Card(color: Colors.red, child: ListTile())
      )
    );
  }

  _showError(error, stackTrace) {
    ShowAlerts.openErrorDialog(context, 'Error de eliminación', 'No se podido eliminar el registro.');
  }

  _enable () => setState(() {
    enabled = true;
  });

  _disable () => setState(() {
    enabled = false;
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) => IconButton(
        onPressed: () => (enabled) ? _delete(ref) : null,
        icon: const Icon(Icons.delete_rounded),
      )
    );
  }
}
