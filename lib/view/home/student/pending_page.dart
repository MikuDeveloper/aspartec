import 'package:flutter/material.dart';

import '../../../globals.dart';

class PendingPage extends StatelessWidget {
  const PendingPage({super.key});

  Widget _builder(context, index, animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(studentPendingAdvicesList[index].adviceSubjectName!),
          subtitle: Text(studentPendingAdvicesList[index].adviceTopicName!),
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
