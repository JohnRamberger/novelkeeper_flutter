import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:novelkeeper_flutter/Component/shallow_novel_card.component.dart';

import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';

class NovelGrid extends StatelessWidget {
  const NovelGrid(
      {required this.novels,
      this.crossAxisCount = 3,
      this.fontSize = 14,
      this.maxLines = -1,
      super.key});

  final List<ShallowNovel> novels;
  final int crossAxisCount;
  final double fontSize;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final columnSizes = [for (var i = 0; i < crossAxisCount; i++) 1.fr];
    final rowSizes = [
      for (var i = 0; i < novels.length / crossAxisCount; i++) auto
    ];

    return LayoutGrid(
      columnSizes: columnSizes,
      rowSizes: rowSizes,
      rowGap: 10,
      columnGap: 10,
      children: [
        for (var novel in novels)
          ShallowNovelCard(novel: novel, fontSize: fontSize, maxLines: maxLines)
      ],
    );
  }
}
