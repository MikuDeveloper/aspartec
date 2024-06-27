import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controller/advisor/close_advice_controller.dart';
import '../../../../model/entities/advice_entity.dart';

class CloseAdviceBottomSheet extends StatelessWidget {
  final AdviceEntity advice;
  final int index;
  const CloseAdviceBottomSheet(
      {super.key, required this.advice, required this.index});

  _showModal(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: false,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  top: 30,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 15),
              child: SingleChildScrollView(
                child: _CloseAdviceView(advice: advice, index: index),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     IconButton(
    //       onPressed: () => _showModal(context),
    //       //icon: const Icon(Icons.grading_rounded,
    //       icon: const Icon(Icons.add_task,
    //       size: 24,
    //       //color: Color.fromARGB(255, 0, 145, 255),
    //       )
    //     ),
    //   ],
    // );
    return InkWell(
      onTap: () => _showModal(context),
    );
  }
}

class _CloseAdviceView extends StatefulWidget {
  final AdviceEntity advice;
  final int index;
  const _CloseAdviceView({required this.advice, required this.index});

  @override
  State<_CloseAdviceView> createState() => _CloseAdviceViewState();
}

class _CloseAdviceViewState extends State<_CloseAdviceView> {
  File? _selectedFile;
  late int rating = 0;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
  }

  Future<void> _cropImage(String path) async {
    final croppedFile = await ImageCropper.platform.cropImage(
        sourcePath: path,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
        ],
        compressQuality: 100,
        maxWidth: 1000,
        maxHeight: 1000,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Recortar imagen',
              toolbarColor: Colors.blue,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          IOSUiSettings(
              title: 'Recortar imagen',
              doneButtonTitle: 'Hecho',
              cancelButtonTitle: 'Cancelar'),
          WebUiSettings(
              context: context, mouseWheelZoom: true, enableZoom: true)
        ]);
    if (croppedFile != null) {
      setState(() {
        _selectedFile = File(croppedFile.path);
      });
    }
  }

  Widget _setOptions() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.keyboard_arrow_down_rounded),
        const SizedBox(height: 10),
        const Text('Cierre Asesoría',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const Text('Para cerrar la asesoría debes subir una '
            'evidencia del trabajo realizado durante la misma '
            'y calificar el desempeño del estudiante. '
            'Posteriormente el estudiante también tendrá que asignar una '
            'calificación.'),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () => _pickImage(ImageSource.camera),
          label: const Text('Tomar foto'),
          icon: const Icon(Icons.add_a_photo_rounded),
        ),
        const SizedBox(height: 10),
        FilledButton.icon(
          onPressed: () => _pickImage(ImageSource.gallery),
          label: const Text('Seleccionar de la galería'),
          icon: const Icon(Icons.image_search_rounded),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _setImageAndClose() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.keyboard_arrow_down_rounded),
        const SizedBox(height: 10),
        const Text('Cierre de asesoría',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 400),
          child: Image.file(_selectedFile!),
        ),
        const SizedBox(height: 30),
        const Text('Asigna una calificación al estudiante:',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        Text(widget.advice.studentName ?? ''),
        const SizedBox(height: 20),
        RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            itemCount: 5,
            direction: Axis.horizontal,
            itemPadding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (BuildContext context, _) =>
                const Icon(Icons.star_rate_rounded, color: Colors.amberAccent),
            onRatingUpdate: (double value) {
              setState(() => rating = value.toInt());
            }),
        const SizedBox(height: 30),
        CloseAdviceController(
            advice: widget.advice,
            file: _selectedFile!,
            rating: rating,
            index: widget.index),
        const SizedBox(height: 30),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _selectedFile == null ? _setOptions() : _setImageAndClose();
  }
}
