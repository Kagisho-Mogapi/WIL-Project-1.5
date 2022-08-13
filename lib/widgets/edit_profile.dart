import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    required this.hint,
    required this.regExp,
    required this.controller,
    required this.detailName,
  }) : super(key: key);

  final String hint;
  final String regExp;
  final String detailName;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 17, color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.white70),
        labelText: hint,
        isDense: true,
      ),
      validator: (value) {
        if (value!.length == 0) {
          return null;
        }
        if (!RegExp(regExp).hasMatch(value)) {
          return 'Enter Correct Info For This Field';
        }
      },
    );
  }
}

class MyPasswordFormField extends StatelessWidget {
  const MyPasswordFormField({
    Key? key,
    required this.hint,
    required this.regExp,
    required this.controller,
  }) : super(key: key);

  final String hint;
  final String regExp;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      style: TextStyle(fontSize: 17, color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.white70),
        labelText: hint,
        isDense: true,
      ),
      validator: (value) {
        if (value!.length == 0) {
          return null;
        }
        if (!RegExp(regExp).hasMatch(value)) {
          return 'Enter Correct Info For This Field';
        }
      },
    );
  }
}
