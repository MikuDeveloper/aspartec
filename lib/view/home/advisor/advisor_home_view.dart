import 'package:aspartec/view/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/advisor/advices_page_controller.dart';
import '../../../controller/advisor/reports_page_controller.dart';
import '../../../controller/advisor/subjects_page_controller.dart';
//import '../../../generated/assets.dart';
import '../../../model/entities/user_entity.dart';
import '../../profile/profile_view.dart';
import '../../widgets/avatar_widget.dart';
import '../student/request_advice_bottom_sheet.dart';
import '../student/student_home_view.dart';
import 'modals/subject_register_bottom_sheet.dart';

class AdvisorHomeView extends StatefulWidget {
  final UserEntity user;
  const AdvisorHomeView({super.key, required this.user});

  @override
  State<AdvisorHomeView> createState() => _AdvisorHomeViewState();
}

class _AdvisorHomeViewState extends State<AdvisorHomeView> {

  late int currentIndex = 0;
  final List<String> titles = ['Módulo Asesor Par', 'Módulo Estudiante', 'Mis Materias', 'Mi Reporte'];
  late List<Widget?> buttons = [null, null, null, null];

  @override
  void initState() {
    buttons = [
      null,
      const RequestAdviceBottomSheet(),
      SubjectRegisterBottomSheet(user: widget.user),
      null
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
          style: GoogleFonts.ptSans(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: const Padding(
          padding: EdgeInsets.all(7),
          //child: LogoWidget()
          child: IconWidget()
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: GestureDetector(
              onTap: () => context.pushNamed(ProfileView.routeName, extra: { 'user': widget.user }),
              child: AvatarWidget(url: widget.user.photoUrl)
            )
          )
        ],
      ),
      body: [
        const AdvicesPageController(),
        StudentHomeView(user: widget.user, hiddenBar: true),
        const SubjectsPageController(),
        const ReportsPageController()
      ][currentIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          setState(() { currentIndex = index; });
        },
        destinations: const <Widget> [
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month_rounded),
            label: 'Asesor Par',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school_rounded),
            label: 'Estudiante',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book_rounded),
            label: 'Materias',
          ),
          NavigationDestination(
            icon: Icon(Icons.assessment_outlined),
            selectedIcon: Icon(Icons.assessment_rounded),
            label: 'Reporte',
          )
        ],
      ),
      floatingActionButton: buttons[currentIndex],
    );
  }
}
