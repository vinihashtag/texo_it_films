import 'package:flutter/material.dart';

class DefaultTitleTableWidget extends StatelessWidget {
  final String text;
  const DefaultTitleTableWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
    ));
  }
}
