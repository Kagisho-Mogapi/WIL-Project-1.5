import 'package:flutter/material.dart';

class MaterialBtnA extends StatelessWidget {
  const MaterialBtnA({
    Key? key,
    required this.btnName,
    required this.location,
  }) : super(key: key);

  final String btnName;
  final String location;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      minWidth: 200,
      color: Colors.orange,
      onPressed: () {
        Navigator.of(context).pushNamed(location);
      },
      child: Text(
        btnName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
