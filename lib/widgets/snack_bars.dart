import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    duration: Duration(milliseconds: 4500),
    elevation: 10,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
    )),
    backgroundColor: Colors.amber[900],
    content: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
