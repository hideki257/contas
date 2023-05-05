import 'package:flutter/material.dart';

class MeuCheckBox extends StatelessWidget {
  final bool? value;
  final String campo;
  final ValueChanged<bool?>? onChanged;

  const MeuCheckBox({
    super.key,
    required this.campo,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool? value = this.value;

    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(campo),
      ],
    );
  }
}
