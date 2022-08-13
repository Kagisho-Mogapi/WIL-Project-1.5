import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OpenTextField extends StatelessWidget {
  const OpenTextField({
    Key? key,
    required this.hint,
    required this.regExp,
    required this.controller,
    required this.isPass,
    required this.isValidInput,
    required this.errorMsg,
  }) : super(key: key);

  final String hint;
  final String regExp;
  final TextEditingController controller;
  final bool isPass;
  final bool isValidInput;
  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      obscureText: isPass,
      style: TextStyle(fontSize: 15, color: Colors.grey[800]),
      controller: controller,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.amber[400]),
        labelStyle: TextStyle(color: Colors.grey[800]),
        errorText: isValidInput ? null : errorMsg,
        labelText: hint,
        isDense: true,
      ),
      validator: (value) {
        if (value!.length == 0 || !RegExp(regExp).hasMatch(value)) {
          return 'Enter All Info';
        }
      },
    );
  }
}
