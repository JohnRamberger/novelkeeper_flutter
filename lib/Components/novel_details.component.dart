import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Model/novel/novel.model.dart';

class NovelDetails extends StatelessWidget {
  const NovelDetails({required this.novel, super.key});

  final Novel novel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(novel.title),
        ),
        Container(
          child: Text(novel.description),
        ),
        Container(
          child: Text(novel.coverUrl),
        ),
        Container(
          child: Text(novel.sourceUrl),
        ),
        Container(
          child: Text(novel.status),
        ),
        Container(
          child: Text(novel.authors.toString()),
        ),
        Container(
          child: Text(novel.alternateTitles.toString()),
        ),
        Container(
          child: Text(novel.genres.toString()),
        ),
        Container(
          child: Text(novel.isFavorite.toString()),
        ),
      ],
    );
  }
}
