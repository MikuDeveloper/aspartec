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
  _openWhatsApp(context, String numberPhone) {
    Launchers.openWhatsApp(context: context, phoneNumber: numberPhone);
  }

  void _openCloseAdviceBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CloseAdviceBottomSheet(
          advice: advisorPendingAdvicesList[index],
          index: index,
        );
      },
    );
  }

  Widget _builder(context, index, animation) {
    final subject = advisorPendingAdvicesList[index].adviceSubjectName!;
    final topic = advisorPendingAdvicesList[index].adviceTopicName!;
    final student = advisorPendingAdvicesList[index].studentName!;
    final studentPhone = advisorPendingAdvicesList[index].studentPhoneNumber!;
    final subtitle = 'Tema: $topic\n$student';

    return SizeTransition(
      sizeFactor: animation,

      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Card(
          child: InkWell(
            // onTap: () => CloseAdviceBottomSheet(
            //   advice: advisorPendingAdvicesList[index],
            //   index: index
            // ),
            // onTap: () => _openCloseAdviceBottomSheet(context, index),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return CloseAdviceBottomSheet(
                    advice: advisorPendingAdvicesList[index],
                    index: index,
                  );
                },
             );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person,
                        size: 28,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject,
                          style: GoogleFonts.ptSans(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "Tema: $topic",
                          style: GoogleFonts.ptSans(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Text(
                          student,
                          style: GoogleFonts.ptSans(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: ()=> _openWhatsApp(context, studentPhone),
                            icon: const ImageIcon(
                              AssetImage("assets/icon/whatsapp.png"),
                              color: Color(0xFF25D366),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

      // child: Column(
      //   children: [
      //     ListTile(
      //         title: Text(
      //           subject,
      //           style: GoogleFonts.ptSans(
      //             textStyle: const TextStyle(
      //               fontSize: 16,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //         subtitle: Text(
      //           subtitle,
      //           style: GoogleFonts.ptSans(
      //             textStyle: const TextStyle(
      //               fontSize: 14,
      //               fontWeight: FontWeight.normal,
      //             ),
      //           ),
      //         ),
      //         leading: const Icon(
      //           Icons.person,
      //           size: 24,
      //         ),
      //         trailing: CloseAdviceBottomSheet(
      //           advice: advisorPendingAdvicesList[index],
      //           index: index,
      //         ),
      //   ],
      // ),

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
