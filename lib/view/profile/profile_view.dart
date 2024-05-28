import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../controller/login/logout_controller.dart';
import '../../model/entities/user_entity.dart';
import '../widgets/avatar_widget.dart';
import 'modals/update_academic_data_bottom_sheet.dart';
import 'modals/update_password_bottom_sheet.dart';
import 'modals/update_personal_data_bottom_sheet.dart';
import 'update_avatar_view.dart';

class ProfileView extends StatelessWidget {
  static const String routeName = 'profile';
  final UserEntity user;
  const ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Perfil de usuario'),
      ),
      body: ListView(
        children: [
          AvatarWidget(maxRadius: 150, url: user.photoUrl),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Icons.add_photo_alternate_rounded),
            title: const Text('Actualizar foto de perfil'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => context.pushNamed(UpdateAvatarView.routeName, extra: { 'user' : user })
          ),
          const UpdatePasswordBottomSheet(),
          const Divider(),
          const UpdatePersonalDataBottomSheet(),
          const UpdateAcademicDataBottomSheet(),
          const Divider(),
          const LogoutController()
        ],
      ),
    );
  }
}
