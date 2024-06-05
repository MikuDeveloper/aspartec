import 'dart:io';
import 'package:aspartec/controller/profile/update_avatar_controller.dart';
import 'package:aspartec/model/entities/user_entity.dart';
import 'package:aspartec/model/implementation/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UpdateAvatarView extends StatefulWidget {
  static const String routeName = 'update-avatar';
  final UserEntity user;
  const UpdateAvatarView({super.key, required this.user});

  @override
  State<UpdateAvatarView> createState() => _UpdateAvatarViewState();
}

class _UpdateAvatarViewState extends State<UpdateAvatarView> {
  final userRepository = UserRepositoryImpl();
  File? _selectedFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
  }

  Future<void> _cropImage(String path) async {
    final croppedFile = await ImageCropper.platform.cropImage(
        sourcePath: path,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        cropStyle: CropStyle.circle,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Recortar imagen',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true
          ),
          IOSUiSettings(
            title: 'Recortar imagen',
            doneButtonTitle: 'Hecho',
            cancelButtonTitle: 'Cancelar'
          ),
          WebUiSettings(
            context: context,
            mouseWheelZoom: true,
            enableZoom: true
          )
        ]
    );
    if (croppedFile != null) {
      setState(() {
        _selectedFile = File(croppedFile.path);
      });
    }
  }

  Widget _setAvatarOrMessage(double maxRadius) {
    return _selectedFile == null
        ? const Text('Selecciona una imagen')
        : CircleAvatar(maxRadius: maxRadius, backgroundImage: FileImage(_selectedFile!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foto de perfil'),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final orientation = MediaQuery.of(context).orientation;
            if (orientation == Orientation.portrait) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _setAvatarOrMessage(MediaQuery.of(context).size.width * 0.4),
                  const SizedBox(height: 20),
                  (_selectedFile == null) ? FilledButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image_search_rounded),
                    label: const Text('Seleccionar imagen')
                  ) : UpdateAvatarController(file: _selectedFile!, user: widget.user)
                ],
              );
            } else {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _setAvatarOrMessage(MediaQuery.of(context).size.height * 0.35),
                  const SizedBox(width: 20),
                  (_selectedFile == null) ? FilledButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image_search_rounded),
                    label: const Text('Seleccionar imagen')
                  ) : UpdateAvatarController(file: _selectedFile!, user: widget.user)
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
