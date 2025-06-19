import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskUtils {
  static final telefoneMask = MaskTextInputFormatter(mask: '(##) #####-####');
  static final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
}

enum FieldValidatorType { required, email }

typedef FieldValidatorFunction = String? Function(String? value, String label);
final Map<FieldValidatorType, FieldValidatorFunction> fieldValidators = {
  FieldValidatorType.required: (value, label) {
    if (value == null || value.isEmpty) {
      return '$label é obrigatório';
    }
    return null;
  },
  FieldValidatorType.email: (value, label) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) return null;
    if (!emailRegex.hasMatch(value)) {
      return 'E-mail inválido, deve ser algo como nome@email.com';
    }
    return null;
  },
};

String? _applyFieldValidators(
  List<FieldValidatorType>? validators,
  String? value,
  String label,
) {
  if (validators == null) return null;
  for (var validatorType in validators) {
    final result = fieldValidators[validatorType]?.call(value, label);
    if (result != null) return result;
  }
  return null;
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
