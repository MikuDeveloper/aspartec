import 'package:flutter/material.dart';

import '../widgets/logo_widget.dart';
import 'modals/login_bottom_sheet.dart';

class LoginLandscapeView extends StatelessWidget {
  const LoginLandscapeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Tecnológico Nacional de México Campus Ciudad Hidalgo'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                LogoWidget(),
                SizedBox(width: 50),
                Column(
                  children: [
                    Text('ASESORÍAS ACADÉMICAS'),
                    Text('DE CIENCIAS BÁSICAS')
                  ],
                ),
              ],
            ),
            LoginBottomSheet()
          ],
        ),
      ),
    );
  }
}
