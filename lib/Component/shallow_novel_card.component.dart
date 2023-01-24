// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';
import 'package:novelkeeper_flutter/View/novel/novel_details.view.dart';

class ShallowNovelCard extends StatelessWidget {
  const ShallowNovelCard(
      {required this.novel, this.fontSize = 14, this.maxLines = -1, super.key});

  final ShallowNovel novel;
  final double fontSize;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(8),
        child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                        image: NetworkImage(novel.coverUrl), fit: BoxFit.fill),
                  ))
                ]),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    novel.title,
                    overflow: maxLines > 0 ? TextOverflow.ellipsis : null,
                    maxLines: maxLines > 0 ? maxLines : null,
                    style: TextStyle(fontSize: fontSize),
                  ),
                )
              ],
            )),
        onTap: () {
          // navigate to novel details view
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NovelDetailsView(shallowNovel: novel)));
        });
    // TODO: add long press action menu
  }
}
