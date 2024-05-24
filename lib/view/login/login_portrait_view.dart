import 'package:flutter/material.dart';

import '../widgets/logo_widget.dart';
import 'modals/login_bottom_sheet.dart';

class LoginPortraitView extends StatelessWidget {
  const LoginPortraitView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                Text('Tecnológico Nacional de México'),
                Text('Campus Ciudad Hidalgo'),
              ],
            ),
            Column(
              children: [
                LogoWidget(),
                SizedBox(height: 20),
                Text('PROGRAMA DE ASESORÍAS ACADÉMICAS'),
                Text('DE CIENCIAS BÁSICAS')
              ],
            ),
            LoginBottomSheet()
          ],
        ),
      ),
    );
  }
}
