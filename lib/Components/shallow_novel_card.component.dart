import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';
import 'package:novelkeeper_flutter/Views/novel/novel_details.view.dart';

class ShallowNovelCard extends StatelessWidget {
  const ShallowNovelCard({required this.novel, super.key});

  final ShallowNovel novel;

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
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: const TextStyle(fontSize: 14),
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
  }
}
