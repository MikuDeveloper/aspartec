import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../generated/assets.dart';
import '../../../globals.dart';
import '../../utils/show_snackbars.dart';

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
  late String subjects = '';

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

    final subjectsList = advisorSubjectsList.map((item) => item.subjectName).toList();
    final subjectsLast = subjectsList.length - 1;
    for (final subject in subjectsList) {
      if (subject == subjectsList[subjectsLast]) {
        setState(() => subjects += '$subject.');
      } else {
        setState(() => subjects += '$subject\n');
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

    final PdfDocument document = PdfDocument(inputBytes: list);

    PdfForm form = document.form;

    // Date field
    PdfTextBoxField dateField = form.fields[0] as PdfTextBoxField;
    final date = DateTime.now();
    final dateText = '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    dateField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    dateField.text = dateText;
    dateField.readOnly = true;

    // Name field
    PdfTextBoxField nameField = form.fields[1] as PdfTextBoxField;
    nameField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    nameField.text = '${userData.firstname} ${userData.lastname1} ${userData.lastname2 ?? ''}'.trim();
    nameField.readOnly = true;

    // Major field
    PdfTextBoxField majorField = form.fields[2] as PdfTextBoxField;
    majorField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    majorField.text = '${userData.major}';
    majorField.readOnly = true;

    // Control number field
    PdfTextBoxField controlField = form.fields[3] as PdfTextBoxField;
    majorField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    controlField.text = '${userData.controlNumber}';
    controlField.readOnly = true;

    // Subjects
    PdfTextBoxField subjectsField = form.fields[4] as PdfTextBoxField;
    subjectsField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    subjectsField.text = subjects;
    subjectsField.readOnly = true;

    // Rating field
    PdfTextBoxField ratingField = form.fields[5] as PdfTextBoxField;
    ratingField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    ratingField.text = rating.toStringAsFixed(1);
    ratingField.readOnly = true;

    // Advices number field
    PdfTextBoxField advicesNumberField = form.fields[6] as PdfTextBoxField;
    advicesNumberField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    advicesNumberField.text = '$advicesNumber';
    advicesNumberField.readOnly = true;

    // Completed advices number field
    PdfTextBoxField canceledAdvicesField = form.fields[7] as PdfTextBoxField;
    canceledAdvicesField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    canceledAdvicesField.text = '$canceledAdvicesNumber';
    canceledAdvicesField.readOnly = true;

    // Completed advices number field
    PdfTextBoxField completedAdvicesField = form.fields[8] as PdfTextBoxField;
    completedAdvicesField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    completedAdvicesField.text = '$completedAdvicesNumber';
    completedAdvicesField.readOnly = true;

    // Sistemas field
    PdfTextBoxField sistemasField = form.fields[9] as PdfTextBoxField;
    sistemasField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    sistemasField.text = '$sistemas';
    sistemasField.readOnly = true;

    // Tics field
    PdfTextBoxField ticsField = form.fields[10] as PdfTextBoxField;
    ticsField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    ticsField.text = '$tics';
    ticsField.readOnly = true;

    // Meca field
    PdfTextBoxField mecaField = form.fields[11] as PdfTextBoxField;
    mecaField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    mecaField.text = '$meca';
    mecaField.readOnly = true;

    // Industrial field
    PdfTextBoxField industrialField = form.fields[12] as PdfTextBoxField;
    industrialField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    industrialField.text = '$meca';
    industrialField.readOnly = true;

    // Bioquimica field
    PdfTextBoxField bioquimicaField = form.fields[13] as PdfTextBoxField;
    bioquimicaField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    bioquimicaField.text = '$bioquimica';
    bioquimicaField.readOnly = true;

    // Gestion field
    PdfTextBoxField gestionField = form.fields[14] as PdfTextBoxField;
    gestionField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    gestionField.text = '$gestion';
    gestionField.readOnly = true;

    // Nano field
    PdfTextBoxField nanoField = form.fields[15] as PdfTextBoxField;
    nanoField.font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    nanoField.text = '$nano';
    nanoField.readOnly = true;


    File('$directoryPath/reporte-de-asesorias-$dateText.pdf').writeAsBytesSync(await document.save());
    document.dispose();
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
            Text('Puntuación promedio: ${rating.toStringAsFixed(1)}', style: const TextStyle(fontWeight: FontWeight.w500)),
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
