import 'package:flutter/material.dart';

class ShowSnackbars {
  static void openInformativeSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        action: SnackBarAction(
          label: 'Aceptar',
          onPressed: () {},
        ),
      ),
    );
  }
}