import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class GenreTag extends StatelessWidget {
  const GenreTag({required this.labelText, super.key});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //     padding: const EdgeInsets.all(8),
    //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
    //     child: Text(labelText));
    return Badge(
        badgeContent: Text(labelText),
        badgeAnimation: ,
        badgeStyle: BadgeStyle(
          shape: BadgeShape.square,
          borderRadius: BorderRadius.circular(8),
          badgeColor: Colors.green,
        ));
  }
}
