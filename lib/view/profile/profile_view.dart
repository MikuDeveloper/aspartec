import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../controller/login/logout_controller.dart';
import '../../model/entities/user_entity.dart';
import '../widgets/avatar_widget.dart';
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
          ListTile(
            leading: const Icon(Icons.key_rounded),
            title: const Text('Cambiar contraseña'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Datos personales'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.menu_book_rounded),
            title: const Text('Datos escolares'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {},
          ),
          const Divider(),
          const LogoutController()
        ],
      ),
    );
  }
}
