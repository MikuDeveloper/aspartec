import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowAlerts {
  static void openErrorDialog(context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
        ),
        content: Text(content),
        actions: [
          FilledButton(
            onPressed: () => context.pop(),
            child: const Text('Aceptar')
          )
        ],
        icon: const Icon(Icons.error_rounded),
        iconColor: Colors.red,
      ),
    );
  }

  static Future<bool> openLogoutDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: const Text(
          '¿Desea cerrar la sesión actual?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancelar')
          ),
          FilledButton(
            onPressed: () => context.pop(true),
            child: const Text('Aceptar')
          )
        ],
        icon: const Icon(Icons.logout_rounded)
      )
    ) ?? false;
  }

  static Future<bool> openDecisiveDialog(BuildContext context, String content, Icon icon, Color iconColor) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Text(
          content,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancelar')
          ),
          FilledButton(
            onPressed: () => context.pop(true),
            child: const Text('Aceptar')
          )
        ],
        icon: icon,
        iconColor: iconColor,
      )
    ) ?? false;
  }
}