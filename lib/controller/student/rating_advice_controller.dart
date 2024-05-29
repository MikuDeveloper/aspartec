import 'package:aspartec/controller/utils/loading.dart';
import 'package:aspartec/model/implementation/advices_repository_impl.dart';
import 'package:aspartec/providers/advices_provider.dart';
import 'package:aspartec/view/utils/show_alerts.dart';
import 'package:aspartec/view/utils/show_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RatingAdviceController extends StatefulWidget {
  final String id;
  final int rating;
  const RatingAdviceController({super.key, required this.rating, required this.id});

  @override
  State<RatingAdviceController> createState() => _RatingAdviceControllerState();
}

class _RatingAdviceControllerState extends State<RatingAdviceController> implements Loading {
  final adviceRepository = AdvicesRepositoryImpl();

  _updateStudentRating(WidgetRef ref) {
    onLoading();
    adviceRepository.ratingAdvisor(widget.id, widget.rating)
    .then((_) {
      ref.read(studentCompletedProvider.notifier).loadAdvices();
      ShowSnackbars.openInformativeSnackBar(context, 'Calificación establecida con éxito.');
      context.pop();
    })
    .catchError((error, stackTrace) {
      ShowAlerts.openErrorDialog(context, 'ERROR', 'Ocurrió un error al registrar la calificación. Inténtelo de nuevo.');
    })
    .whenComplete(() => offLoading());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) => FilledButton(
        onPressed: () {
          if (widget.rating != 0) _updateStudentRating(ref);
        },
        child: const Text('Registrar calificación'),
      ),
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
