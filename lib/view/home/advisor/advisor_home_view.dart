import 'package:flutter/material.dart';

import '../../../model/entities/user_entity.dart';

class AdvisorHomeView extends StatelessWidget {
  final UserEntity user;
  const AdvisorHomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Asesorías'),
      ),
      body: const Center(
        child: Text('Advisor home view'),
      ),
    );
  }
}
