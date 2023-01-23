import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:novelkeeper_flutter/Model/novel/chapter.model.dart';

class ChapterItem extends StatelessWidget {
  const ChapterItem({required this.chapter, super.key});

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        chapter.title,
        overflow: TextOverflow.ellipsis,
      ),
      onLongPress: () {
        // create popup with full title
        Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          message: chapter.title,
          duration: const Duration(seconds: 3),
          flushbarStyle: FlushbarStyle.FLOATING,
          backgroundColor: Colors.white,
          messageColor: Colors.black,
          margin: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
        ).show(context);
      },
    );
  }
}
