import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../controller/student/pending_page_controller.dart';
import '../../../model/entities/user_entity.dart';
import '../../profile/profile_view.dart';
import '../../widgets/avatar_widget.dart';
import '../../widgets/logo_widget.dart';
import 'request_advice_bottom_sheet.dart';

class StudentHomeView extends StatelessWidget {
  final bool hiddenBar;
  final UserEntity user;
  const StudentHomeView({super.key, required this.user, required this.hiddenBar});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: (hiddenBar) ? 0 : kToolbarHeight,
          title: (hiddenBar) ? null :  const Text('Mis asesorías'),
          leading: (hiddenBar) ? null : const Padding(
            padding: EdgeInsets.all(5),
            child: LogoWidget()
          ),
          actions: (hiddenBar) ? null : [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: GestureDetector(
                onTap: () => context.pushNamed(ProfileView.routeName, extra: { 'user': user }),
                child: AvatarWidget(url: user.photoUrl)
              )
            ),
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.access_time),
                text: 'Pendientes',
              ),
              Tab(
                icon: Icon(Icons.calendar_today),
                text: 'Completadas',
              )
            ]
          )
        ),
        body: const TabBarView(
          children: [
            PendingPageController(),
            Center(child: Text('Completadas')),
          ],
        ),
        floatingActionButton: (hiddenBar) ? null : const RequestAdviceBottomSheet()
      )
    );
  }
}
