import 'package:flutter/material.dart';

class BotaoInterruptor extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const BotaoInterruptor({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
}
