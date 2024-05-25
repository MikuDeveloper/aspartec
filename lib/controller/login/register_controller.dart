import 'package:aspartec/controller/utils/loading.dart';
import 'package:aspartec/model/entities/user_entity.dart';
import 'package:aspartec/model/implementation/user_repository_impl.dart';
import 'package:aspartec/providers/error_provider.dart';
import 'package:aspartec/view/home/home_view.dart';
import 'package:aspartec/view/utils/show_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../view/utils/error_messages.dart';

class RegisterController extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final UserEntity user;
  final String pass;
  const RegisterController({super.key, required this.formKey, required this.user, required this.pass});

  @override
  State<RegisterController> createState() => _RegisterControllerState();
}

class _RegisterControllerState extends State<RegisterController> implements Loading {
  final userRepository = UserRepositoryImpl();

  void _register () {
    onLoading();
    userRepository.registerUser(widget.user.email!, widget.pass)
    .then((_) {
      userRepository.registerOrUpdateData(widget.user)
        .then((_) => _goToHome())
        .catchError((error, stackTrace) => _showAuthError(error.message))
        .whenComplete(() => offLoading());
    })
    .catchError((error, stackTrace) { _showDataError(error.message); })
    .whenComplete(() => offLoading());
  }

  void _goToHome() {
    context.goNamed(HomeView.routeName);
  }

  void _showAuthError(String code) {
    ShowAlerts.openErrorDialog(
        context,
        'Error de registro',
        ErrorMessages.getAuthErrorMessage(code)
    );
  }

  void _showDataError(String code) {
    ShowAlerts.openErrorDialog(
        context,
        'Error de registro',
        ErrorMessages.getFirestoreErrorMessage(code)
    );
  }

  Widget _showButtonOrLoading(WidgetRef ref) {
    return isLoading ? const CircularProgressIndicator() :
    FilledButton(
      onPressed: () {
        if (widget.formKey.currentState!.validate() && widget.user.gender != null) {
          _register();
          return;
        }

        if(widget.user.gender == null) {
          ref.read(genderError.notifier).state = 'Selecciona algún genero';
        }

        if(widget.user.major == null) {
          ref.read(majorError.notifier).state = 'Selecciona algún programa';
        }
      },
      child: const Text('Registrarse'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) => _showButtonOrLoading(ref));
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
