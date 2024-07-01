import 'package:aspartec/view/home/advisor/modals/close_advice_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../globals.dart';
import '../../utils/lauchers.dart';

class AdvicesPage extends StatefulWidget {
  const AdvicesPage({super.key});

  @override
  State<AdvicesPage> createState() => _AdvicesPageState();
}

class _AdvicesPageState extends State<AdvicesPage> {
  _openWhatsApp(context, String numberPhone, String name, String subject, bool soyAsesor) {
    Launchers.openWhatsApp(
      context: context,
      phoneNumber: numberPhone,
      name: name,
      subject: subject,
      soyAsesor: soyAsesor);
  }

  Widget _builder(context, index, animation) {
    final subject = advisorPendingAdvicesList[index].adviceSubjectName!;
    final topic = advisorPendingAdvicesList[index].adviceTopicName!;
    final student = advisorPendingAdvicesList[index].studentName!;
    final studentPhone = advisorPendingAdvicesList[index].studentPhoneNumber!;
    final advisorName = advisorPendingAdvicesList[index].advisorName!;
    final subtitle = 'Tema: $topic\n$student';

    return SizeTransition(
      sizeFactor: animation,
      child: Dismissible(
        key: Key(studentPhone),
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
          bool? result = await _openWhatsApp(
            context,
            studentPhone,
            advisorName,
            subject,
            true,
          );
          return result ?? false; // Ensure a boolean is returned
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    subject,
                    style: GoogleFonts.ptSans(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.ptSans(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  leading: const Icon(
                    Icons.person,
                    size: 28,
                  ),
                  trailing: CloseAdviceBottomSheet(
                    advice: advisorPendingAdvicesList[index],
                    index: index,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: advisorPendingAdvicesKey,
        initialItemCount: advisorPendingAdvicesList.length,
        itemBuilder: _builder);
  }
}
