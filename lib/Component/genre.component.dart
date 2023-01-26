import 'package:flutter/material.dart';

class GenreTag extends StatelessWidget {
  const GenreTag({required this.labelText, super.key});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(labelText));
  }
}
