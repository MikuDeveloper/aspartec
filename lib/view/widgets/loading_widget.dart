import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String title;
  const LoadingWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title),
          const SizedBox(height: 20),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}
