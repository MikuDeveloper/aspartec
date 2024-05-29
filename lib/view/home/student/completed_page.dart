import 'package:aspartec/globals.dart';
import 'package:aspartec/view/home/student/rating_advice_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: studentCompletedAdvicesList.length,
      itemBuilder: (context, index) {
        final id = studentCompletedAdvicesList[index].id!;
        final subject = studentCompletedAdvicesList[index].adviceSubjectName!;
        final advisor = studentCompletedAdvicesList[index].advisorName!;
        final studentRating = studentCompletedAdvicesList[index].adviceStudentRating!;
        final rating = studentRating > 0;

        return Card(
          child: Column(
            children: [
              ListTile(
                title: Text(subject),
                subtitle: Text('Asesor: $advisor'),
              ),
              rating ? RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: studentRating.toDouble(),
                  minRating: 1,
                  itemCount: 5,
                  direction: Axis.horizontal,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (BuildContext context, _) =>
                  const Icon(Icons.star_rate_rounded, color: Colors.amberAccent),
                  onRatingUpdate: (_) {},
              )
                  : RatingAdviceBottomSheet(id: id, advisor: advisor),
              const SizedBox(height: 10)
            ],
          )
        );
      }
    );
  }
}
