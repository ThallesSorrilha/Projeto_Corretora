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
