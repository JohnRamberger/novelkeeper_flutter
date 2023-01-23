import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';

class ShallowNovelCard extends StatelessWidget {
  const ShallowNovelCard({required this.novel, super.key});

  final ShallowNovel novel;

  @override
  Widget build(BuildContext context) {
    return Image(image: NetworkImage(novel.coverUrl)));
  }
}
