import 'package:flutter/material.dart';

import '../../../globals.dart';
import '../../utils/lauchers.dart';

class AdvicesPage extends StatelessWidget {
  const AdvicesPage({super.key});

  _openWhatsApp(context, String numberPhone) {
    Launchers.openWhatsApp(context: context, phoneNumber: numberPhone);
  }

  Widget _builder(context, index, animation) {
    final subject = advisorPendingAdvicesList[index].adviceSubjectName!;
    final topic = advisorPendingAdvicesList[index].adviceTopicName!;
    final student = advisorPendingAdvicesList[index].studentName!;
    final studentPhone = advisorPendingAdvicesList[index].studentPhoneNumber!;
    final subtitle = '- Tema: $topic\n- Estudiante: $student';

    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(subject),
              subtitle: Text(subtitle),
              leading: const Icon(Icons.menu_book_rounded),
              /*trailing: IconButton(
                onPressed: () => _close(context, index, advisorSubjectsList[index].id!),
                icon: const Icon(Icons.bookmark_remove_outlined),
              )*/
            ),
            FilledButton.tonalIcon(
              onPressed: () => _openWhatsApp(context, studentPhone),
              label: const Text('Contactar'),
              icon: const Icon(Icons.connect_without_contact_rounded)
            )
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: advisorPendingAdvicesKey,
      initialItemCount: advisorPendingAdvicesList.length,
      itemBuilder: _builder
    );
  }
}
