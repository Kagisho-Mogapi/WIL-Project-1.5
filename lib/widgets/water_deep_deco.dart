import 'package:flutter/material.dart';

BoxDecoration waterDeepDeco() {
  return BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.lightBlue,
          Colors.blue.shade900,
        ]),
  );
}
