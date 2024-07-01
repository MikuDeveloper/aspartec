//import 'dart:ffi';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'show_alerts.dart';

class Launchers {
  static Future<bool?> openWhatsApp({
    required context,
    required String phoneNumber,
    required String name,
    required String subject,
    required bool soyAsesor,
  }) async {
    String message;

    if (soyAsesor) {
      message =
          '¡Hola!, Soy tu Asesor Par $name de AsparTec, estoy listo para resolver tus dudas de la materia de $subject, quedo pendiente de tu respuesta para empezar a trabajar con tu inquietud, ¡Saludos!';
    } else {
      message =
          '¡Hola!, Soy $name, estoy solicitando una asesoría por medio de AsparTec, referente a la materia de $subject, quedo pendiente de sus indicaciones para proceder a resolver mis dudas, ¡Saludos!';
    }
    // const message =
    //     'Hola, te he solicitado una asesoría a través de la app ASPARTEC. ¡Vamos a trabajar!';
    final url = Platform.isAndroid
        ? 'whatsapp://send?phone=$phoneNumber&text=${Uri.parse(message)}'
        : 'whatsapp://wa.me/$phoneNumber?text=${Uri.parse(message)}';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
      return true;
    } else {
      ShowAlerts.openErrorDialog(
          context, 'ERROR', 'No se pudo abrir WhatsApp.');
      return false;
    }
  }
}
