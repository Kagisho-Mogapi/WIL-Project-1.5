import 'package:flutter/material.dart';

class SignUpTextField extends StatelessWidget {
  const SignUpTextField({
    Key? key,
    required this.controller,
    required this.labeltext,
    required this.keyboardType,
    required this.isValidInput,
    required this.errorMsg,
    this.hideText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String labeltext;
  final TextInputType keyboardType;
  final bool hideText;

  final bool isValidInput;
  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
      child: TextField(
        obscureText: hideText,
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.white,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          errorText: isValidInput ? null : errorMsg,
          errorStyle: TextStyle(color: Colors.amber[400]),
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          labelText: labeltext,
        ),
      ),
    );
  }
}
