class ErrorMessages {
  static String getAuthErrorMessage(String code) {
    switch (code) {
      case 'network-request-failed':
        return 'Solicitud sin respuesta. Verifique su conexión a internet.';
      case 'missing-email':
        return 'Email no proveído. Ingrese un valor en el campo.';
      case 'missing-password':
        return 'Contraseña no proveída. Ingrese un valor en el campo.';
      case 'invalid-email':
        return 'El correo ingresado es inválido.';
      case 'email-already-in-use':
        return 'Este correo ya ha sido registrado, pruebe con con otro.';
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos.';
      case 'user-not-found':
        return 'Usuario no encontrado con la dirección proporcionada.';
      default: return code;
    }
  }

  static String getFirestoreErrorMessage(String code) {
    switch (code) {
      case 'network-request-failed':
        return 'Solicitud sin respuesta. Verifique su conexión a internet.';
      case 'permission-denied':
        return 'No tiene los permisos suficientes.';
      default: return code;
    }
  }
}