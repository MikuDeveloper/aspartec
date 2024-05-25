import 'package:flutter/material.dart';

import '../../model/entities/user_entity.dart';

class HomeView extends StatelessWidget {
  final UserEntity user;
  const HomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const Placeholder(),
    );
  }
}
