import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskUtils {
  static final telefoneMask = MaskTextInputFormatter(mask: '(##) #####-####');
  static final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
}

enum FieldValidatorType { required, email }

String? _applyFieldValidators(
  List<FieldValidatorType>? validators,
  String? value,
  String label,
) {
  if (validators == null) return null;
  if (validators.contains(FieldValidatorType.required)) {
    if (value == null || value.isEmpty) {
      return '$label é obrigatório';
    }
  }
  if (validators.contains(FieldValidatorType.email)) {
    if (_verifyEmail(value) == false) {
      return 'E-mail inválido, deve algo como nome@email.com';
    }
  }
  return null;
}

final _emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
bool? _verifyEmail(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  if (_emailRegex.hasMatch(value)) {
    return true;
  }
  return false;
}

Widget buildTextField(
  TextEditingController controller,
  String label, {
  TextInputType keyboardType = TextInputType.text,
  List<TextInputFormatter>? inputFormatters,
  String? hintText,
  FormFieldValidator<String>? validator,
  List<FieldValidatorType>? validators,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      validator:
          validator ??
          (value) => _applyFieldValidators(validators, value, label),
    ),
  );
}

Widget buildDropdownField(
  String label,
  List<String> options,
  ValueChanged<String?> onChanged,
  String? selectionField, {
  FormFieldValidator<String>? validator,
  List<FieldValidatorType>? validators,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      value: selectionField,
      onChanged: onChanged,
      items:
          options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      validator:
          validator ??
          (value) => _applyFieldValidators(validators, value, label),
    ),
  );
}

Widget buildSwitchField(
  String label,
  bool value,
  ValueChanged<bool> onChanged,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.green,
      inactiveThumbColor: Colors.red,
    ),
  );
}
