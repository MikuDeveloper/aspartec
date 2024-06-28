import 'package:flutter/material.dart';

import '../../generated/assets.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = Theme.of(context).brightness == Brightness.light;
    final height = MediaQuery.of(context).size.height;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height * 0.5),
      child: (lightTheme)
          ? Image.asset(Assets.iconAspartecLigth)
          : Image.asset(Assets.iconAspartecDark)
    );
  }
}