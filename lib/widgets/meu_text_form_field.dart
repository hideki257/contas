import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/const_utils.dart';

typedef StringFunction<String> = String? Function(String? value);
typedef CallbackFunction = void Function();

class MeuTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final bool isReadOnly;
  final StringFunction<String>? validator;
  final CallbackFunction? onTap;
  final bool obscureText;
  final bool isData;
  final List<TextInputFormatter>? inputFormatters;

  const MeuTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.isReadOnly = false,
    this.validator,
    this.onTap,
    this.obscureText = false,
    this.isData = false,
    this.inputFormatters,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          filled: isReadOnly,
          fillColor: isReadOnly ? corBackgroundReadOnly : null,
          iconColor: isReadOnly ? corBackgroundReadOnly : null,
          hoverColor: isReadOnly ? corBackgroundReadOnly : null,
          focusColor: isReadOnly ? corBackgroundReadOnly : null,
        ),
        readOnly: isReadOnly || isData,
        validator: validator,
        onTap: onTap,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
