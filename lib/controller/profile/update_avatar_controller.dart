import 'dart:io';

import 'package:aspartec/model/entities/user_entity.dart';
import 'package:aspartec/view/utils/show_snackbars.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../model/implementation/user_repository_impl.dart';
import '../../providers/user_data_provider.dart';
import '../../view/utils/show_alerts.dart';
import '../utils/loading.dart';

class UpdateAvatarController extends StatefulWidget {
  final File file;
  final UserEntity user;
  const UpdateAvatarController({super.key, required this.file, required this.user});

  @override
  State<UpdateAvatarController> createState() => _UpdateAvatarControllerState();
}

class _UpdateAvatarControllerState extends State<UpdateAvatarController> implements Loading {
  final userRepository = UserRepositoryImpl();
  late UserEntity user;
  late File? file;

  @override
  void initState() {
    file = widget.file;
    user = widget.user;
    super.initState();
  }

  void _uploadFile(WidgetRef ref) {
    if(file != null){
      final upload = userRepository.updateAvatar(file!);
      upload.snapshotEvents.listen((taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            onLoading();
            break;
          case TaskState.paused:
            offLoading();
            break;
          case TaskState.success:
            _getUrl(taskSnapshot.ref.fullPath, ref);
            break;
          case TaskState.canceled:
            offLoading();
            break;
          case TaskState.error:
            _showError();
            offLoading();
            break;
        }
      });
    }
  }

  _getUrl(String path, WidgetRef ref) {
    userRepository.getUrlFile(path)
    .then((url) {
      userRepository.updateDataUrl(url)
      .then((_) {
        user = user.copyWith(photoUrl: url);
        ref.read(avatarProvider.notifier).state = url;
        ref.read(userDataProvider.notifier).setData(user);
      })
      .catchError((error, stackTrace) => _showError())
      .whenComplete(() {
        offLoading();
        _back();
      });
    })
    .catchError((error, stackTrace) => _showError());
  }

  _back() {
    context.pop();
    ShowSnackbars.openInformativeSnackBar(context, 'Foto actualizada correctamente.');
  }

  _showError() {
    ShowAlerts.openErrorDialog(
      context,
      'ERROR DE DE ARCHIVO',
      'Ocurrió un error al subir la imagen, vuelva a intertarlo.'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) => (isLoading)
        ? const CircularProgressIndicator()
        : OutlinedButton.icon(
        onPressed: () => _uploadFile(ref),
        icon: const Icon(Icons.file_upload_rounded),
        label: const Text('Actualizar foto'),
      ),
    );
  }

  @override
  bool isLoading = false;

  @override
  void offLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onLoading() {
    setState(() {
      isLoading = true;
    });
  }
}
