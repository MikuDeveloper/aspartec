class FormValidations {
  static final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$");
  static final RegExp _passwordRegExp = RegExp(r'^(?=.*?[A-ZÑ])(?=.*?[a-zñ])(?=.*?[0-9])(?=.*?[!@#%&/*~\-_.]).{6,}$');
  //static final RegExp _phoneNumberRegExp = RegExp(r'^(?=.*?[0-9]).{10}$');
  static final RegExp _phoneNumberRegExp = RegExp(r'^\d{10}$');

  static const String _emptyMessage = 'Ingrese algún valor';
  static const String _emailMessage = 'Correo electrónico inválido';
  static const String _passwordMessage = 'Ingrese al menos 6 caracteres entre\nmayúsculas, '
      'minúsculas, números y alguno\nde los siguientes caracteres'
      ' especiales:\n!, @, #, %, &, /, *, ~, -, _, .';
  static const String _phoneNumberMessage = 'Ingrese un número de celular de 10 dígitos';

  static String? emptyOrNullValidation(String? value) {
    return (value == null || value.isEmpty) ? _emptyMessage : null;
  }

  static String? emailValidation(String? email) {
    return emptyOrNullValidation(email) ??
        (_emailRegExp.hasMatch(email!) ? null : _emailMessage);
  }

  static String? passwordValidation(String? password) {
    return emptyOrNullValidation(password) ??
        (_passwordRegExp.hasMatch(password!) ? null : _passwordMessage);
  }

  static String? phoneNumberValidation(String? phoneNumber) {
    return emptyOrNullValidation(phoneNumber) ??
        (_phoneNumberRegExp.hasMatch(phoneNumber!) ? null : _phoneNumberMessage);
  }
}