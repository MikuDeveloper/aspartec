import 'package:flutter/material.dart';

import 'login_landscape_view.dart';
import 'login_portrait_view.dart';

class LoginView extends StatelessWidget {
  static const String routeName = 'login';
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final orientation = MediaQuery.of(context).orientation;
          return (orientation == Orientation.portrait)
              ? const LoginPortraitView()
              : const LoginLandscapeView();
        },
      ),
    );
  }
}
