import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.black),
      ),
      padding: const EdgeInsets.all(7),
      child: TextField(
        style: TextStyle(fontSize: 19),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search),
          hintText: 'Where do you want to go?',
        ),
      ),
    );
  }
}
