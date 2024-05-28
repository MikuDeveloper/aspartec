import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../globals.dart';
import '../../../providers/error_provider.dart';
import '../../utils/form_values.dart';
import '../../utils/validations.dart';

class UpdateAcademicDataBottomSheet extends StatelessWidget {
  const UpdateAcademicDataBottomSheet({super.key});

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
          left: 15
        ),
        child: const SingleChildScrollView(child: _UpdateAcademicDataForm()),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.menu_book_rounded),
      title: const Text('Datos escolares'),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () => _showModal(context),
    );
  }
}

class _UpdateAcademicDataForm extends StatefulWidget {
  const _UpdateAcademicDataForm();

  @override
  State<_UpdateAcademicDataForm> createState() => _UpdateAcademicDataFormState();
}

class _UpdateAcademicDataFormState extends State<_UpdateAcademicDataForm> {
  final _formKey = GlobalKey<FormState>();

  late bool _readOnly = true;
  late String _controlNumber;
  late String? _major;

  @override
  void initState() {
    super.initState();
    _controlNumber = userData.controlNumber ?? '';
    _major = userData.major;
  }

  void _edit() {
    setState(() => _readOnly = !_readOnly);
  }

  void _setControlNumber(String value) {
    setState(() => _controlNumber = value.trim());
  }

  void _setMajor(String? value, WidgetRef ref) {
    setState(() {
      _major = value;
      ref.read(majorError.notifier).state = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Icon(Icons.keyboard_arrow_down_rounded),
          const SizedBox(height: 10),
          const Text(
            'Datos escolares',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton.outlined(
                onPressed: _edit,
                icon: const Icon(Icons.edit_off_rounded),
                selectedIcon: const Icon(Icons.edit_rounded),
                isSelected: !_readOnly,
              )
            ]
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: FormValidations.emptyOrNullValidation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Número de control'),
                prefixIcon: Icon(Icons.person_search_rounded)
            ),
            onChanged: _setControlNumber,
            initialValue: _controlNumber,
            readOnly: _readOnly,
          ),
          const SizedBox(height: 15),
          Consumer(builder: (context, ref, _) =>
            DropdownMenu(
              dropdownMenuEntries: majorList.map(
                      (item) => DropdownMenuEntry(value: item, label: item)
              ).toList(),
              leadingIcon: const Icon(Icons.menu_book),
              expandedInsets: EdgeInsets.zero,
              label: const Text('Programa educativo'),
              errorText: ref.watch(majorError),
              onSelected: (value) => _setMajor(value, ref),
              initialSelection: _major,
              enabled: !_readOnly,
            ),
          ),
          const SizedBox(height: 30),
          //TODO: Implement controller
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
