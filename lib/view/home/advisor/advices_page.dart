import 'package:aspartec/view/home/advisor/modals/close_advice_bottom_sheet.dart';
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
              trailing: CloseAdviceBottomSheet(advice: advisorPendingAdvicesList[index], index: index)
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
