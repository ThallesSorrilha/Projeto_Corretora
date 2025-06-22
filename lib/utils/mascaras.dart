import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskUtils {
  static final telefoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  static final realMask = MaskTextInputFormatter(
    mask: 'R\$ ###.###.###,##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  static final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
}

/*Widget buildSwitchField(
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
}*/
