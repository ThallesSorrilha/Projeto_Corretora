import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final telefoneMask = MaskTextInputFormatter(mask: '(##) #####-####');
final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');

final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
String? verifyEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'E-mail é obrigatório';
  }
  if (!emailRegex.hasMatch(value)) {
    return 'E-mail inválido, deve algo como nome@email.com';
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
          (value) {
            if (value == null || value.isEmpty) {
              return '$label é obrigatório';
            }
            return null;
          },
    ),
  );
}

Widget buildDropdownField(
  String label,
  List<String> options,
  ValueChanged<String?> onChanged,
  String? selectionField,
) {
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
      validator: (value) {
        if (value == null) {
          return '$label é obrigatório';
        }
        return null;
      },
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
