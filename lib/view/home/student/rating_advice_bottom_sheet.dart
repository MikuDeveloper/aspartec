import 'package:aspartec/controller/student/rating_advice_controller.dart';
import 'package:aspartec/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingAdviceBottomSheet extends StatelessWidget {
  final String id;
  final String advisor;
  const RatingAdviceBottomSheet({super.key, required this.advisor, required this.id});

  _showModal(context, String id, String advisor) {
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
            child: _RatingAdviceView(id: id, advisor: advisor),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
        onPressed: () => _showModal(context, id, advisor),
        label: const Text('Calificar'),
        icon: const Icon(Icons.star_rate_sharp)
    );
  }
}

class _RatingAdviceView extends StatefulWidget {
  final String id;
  final String advisor;
  const _RatingAdviceView({required this.advisor, required this.id});

  @override
  State<_RatingAdviceView> createState() => _RatingAdviceViewState();
}

class _RatingAdviceViewState extends State<_RatingAdviceView> {
  late int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.keyboard_arrow_down_rounded),
        const SizedBox(height: 10),
        const Text(
          'Calificación de asesor',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 400),
          child: SvgPicture.asset(Assets.picturesRatingPicture),
        ),
        const Text(
          'Califica al asesor según su desempeño al asesorarte:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 10),
        Text('Asesor: ${widget.advisor}'),
        const SizedBox(height: 20),
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          itemCount: 5,
          direction: Axis.horizontal,
          itemPadding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (BuildContext context, _) =>
          const Icon(Icons.star_rate_rounded, color: Colors.amberAccent),
          onRatingUpdate: (double value) {
            setState(() => rating = value.toInt());
          }
        ),
        const SizedBox(height: 20),
        RatingAdviceController(id: widget.id, rating: rating),
        const SizedBox(height: 30),
      ],
    );
  }
}

