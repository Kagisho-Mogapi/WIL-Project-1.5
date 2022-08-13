import 'package:flutter/material.dart';

class MyCreateScheduleFields extends StatelessWidget {
  const MyCreateScheduleFields({
    Key? key,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: hint,
        ),
      ),
    );
  }
}
