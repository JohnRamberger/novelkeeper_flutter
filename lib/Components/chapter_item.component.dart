import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:novelkeeper_flutter/Model/novel/chapter.model.dart';

class ChapterItem extends StatelessWidget {
  const ChapterItem({required this.chapter, super.key});

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(chapter.title), subtitle: Text("index: ${chapter.index}"));
  }
}
