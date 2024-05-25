import 'package:aspartec/view/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  static const String routeName = 'profile';
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Perfil de usuario'),
      ),
      body: ListView(
        children: [
          const AvatarWidget(maxRadius: 150),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Icons.add_photo_alternate_rounded),
            title: const Text('Actualizar foto de perfil'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {},
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
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Cerrar sesión'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
