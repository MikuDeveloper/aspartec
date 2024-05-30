import 'dart:io';

import 'package:aspartec/generated/assets.dart';
import 'package:aspartec/view/utils/show_snackbars.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../globals.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late int advicesNumber = 0;
  late int completedAdvicesNumber = 0;
  late int canceledAdvicesNumber = 0;
  late int sistemas = 0;
  late int tics = 0;
  late int meca = 0;
  late int industrial = 0;
  late int gestion = 0;
  late int bioquimica = 0;
  late int nano = 0;
  late double rating = 0.0;

  @override
  void initState() {
    final currentMonth = DateTime.now().month;
    for (final advice in advisorCompletedAdvicesList) {
      final adviceMonth = int.parse(advice.adviceDate!.split('/')[1]);
      final studentMajor = advice.studentMajor!;
      final studentRating = advice.adviceStudentRating!.toDouble();
      if (adviceMonth == currentMonth) {
        setState(() => completedAdvicesNumber += 1);
        setState(() => rating += studentRating);
        _countByMajor(studentMajor);
      }
    }

    for (final advice in advisorCanceledAdvicesList) {
      final adviceMonth = int.parse(advice.adviceDate!.split('/')[1]);
      final studentMajor = advice.studentControlNumber!;
      if (adviceMonth == currentMonth) {
        setState(() => canceledAdvicesNumber += 1);
        _countByMajor(studentMajor);
      }
    }

    setState(() => advicesNumber = completedAdvicesNumber +  canceledAdvicesNumber);
    setState(() => rating = rating / advisorCompletedAdvicesList.length );
    super.initState();
  }

  _countByMajor(String major) {
    switch(major) {
      case 'Ingeniería en Sistemas Computacionales':
        setState(() => sistemas += 1);
        break;
      case 'Ingeniería en Tecnologías de la Información':
        setState(() => tics += 1);
        break;
      case 'Ingeniería Mecatrónica':
        setState(() => meca += 1);
        break;
      case 'Ingeniería Industrial':
        setState(() => industrial += 1);
        break;
      case 'Ingeniería en Gestión Empresarial':
        setState(() => gestion += 1);
        break;
      case 'Ingeniería Bioquímica':
        setState(() => bioquimica += 1);
        break;
      case 'Ingeniería en Nanotecnología':
        setState(() => nano += 1);
        break;
    }
  }

  _generateReport() async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath();
    if(directoryPath == null) return;

    final ByteData bytes = await rootBundle.load(Assets.docsReportTemplate);
    final Uint8List list = bytes.buffer.asUint8List();

    //TODO: Fill in the form and save.
    /*final PdfDocument document = PdfDocument(inputBytes: list);

    PdfForm form = document.form;

    // Name field
    PdfTextBoxField nameField = form.fields[15] as PdfTextBoxField;

    // Date field
    PdfTextBoxField dateField = form.fields[15] as PdfTextBoxField;
    final date = DateTime.now();
    final dateText = '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    dateField.text = dateText;
    File('$directoryPath/reporte-de-asesorias-$dateText.pdf').writeAsBytesSync(await document.save());
    document.dispose();*/
    _showMessage();
  }

  _showMessage() {
    ShowSnackbars.openInformativeSnackBar(context, 'Reporte generado con éxito.');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton.icon(
              onPressed: _generateReport,
              label: const Text('Generar reporte mensual'),
              icon: const Icon(Icons.data_thresholding_outlined),
            )
          ],
        ),
        const Text('Información general (deslice para actualizar)', style: TextStyle(fontWeight: FontWeight.w500)),
        const Divider(),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Asesorías impartidas:'),
            Text('$advicesNumber')
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Asesorías completadas:'),
            Text('$completedAdvicesNumber')
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Asesorías canceladas:'),
            Text('$canceledAdvicesNumber')
          ],
        ),
        const SizedBox(height: 30),

        const Text('Asesorías impartidas por carrera', style: TextStyle(fontWeight: FontWeight.w500)),
        const Divider(),
        const SizedBox(height: 15),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ingeniería en Sistemas Computacionales'),
            Text('$sistemas')
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ingeniería en Tecnologías de la Información'),
            Text('$tics')
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ingeniería Mecatrónica'),
            Text('$meca')
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ingeniería Industrial'),
            Text('$tics')
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ingeniería en Gestión Empresarial'),
            Text('$gestion')
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ingeniería Bioquímica'),
            Text('$bioquimica')
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ingeniería en Nanotecnología'),
            Text('$nano')
          ],
        ),
        const SizedBox(height: 30),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Puntuación promedio: $rating', style: const TextStyle(fontWeight: FontWeight.w500)),
            RatingBar.builder(
              initialRating: rating,
              ignoreGestures: true,
              allowHalfRating: true,
              minRating: 1,
              itemCount: 5,
              direction: Axis.horizontal,
              itemPadding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (BuildContext context, _) =>
              const Icon(Icons.star_rate_rounded, color: Colors.amberAccent),
              onRatingUpdate: (_) {}
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
