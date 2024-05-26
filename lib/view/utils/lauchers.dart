import 'package:url_launcher/url_launcher.dart';

import '../../firebase_options.dart';
import 'show_alerts.dart';

class Launchers {
  static Future<bool> openWhatsApp({required context, required String phoneNumber}) async {
    const message = 'Hola, te he solicitado una asesoría a través de la app ASPARTEC. ¡Vamos a trabajar!';
    final url = DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.android
        ? 'whatsapp://send?phone=$phoneNumber&text=${Uri.parse(message)}'
        : 'whatsapp://wa.me/$phoneNumber?text=${Uri.parse(message)}';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
      return true;
    } else {
      ShowAlerts.openErrorDialog(context, 'ERROR', 'No se pudo abrir Whatsapp.');
      return false;
    }
  }
}
