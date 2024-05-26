import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../controller/advisor/subjects_page_controller.dart';
import '../../../model/entities/user_entity.dart';
import '../../profile/profile_view.dart';
import '../../widgets/avatar_widget.dart';
import '../../widgets/logo_widget.dart';
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
  final List<String> titles = ['Módulo asesor', 'Módulo estudiante', 'Mis materias', 'Mis reportes'];
  late List<Widget?> buttons = [null, null, null, null];

  @override
  void initState() {
    buttons = [
      null,
      null,
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
        title: Text(titles[currentIndex]),
        leading: const Padding(
          padding: EdgeInsets.all(5),
          child: LogoWidget()
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
        const Center(child: Text('Asesorias')),
        StudentHomeView(user: widget.user, hiddenBar: true),
        const SubjectsPageController(),
        const Center(child: Text('Reportes')),
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
            label: 'Asesorías',
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
            label: 'Reportes',
          )
        ],
      ),
      floatingActionButton: buttons[currentIndex],
    );
  }
}
