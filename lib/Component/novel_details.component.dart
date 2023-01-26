import 'package:flutter/cupertino.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:novelkeeper_flutter/Component/genre.component.dart';
import 'package:novelkeeper_flutter/Component/text_closed.component.dart';
// import 'package:novelkeeper_flutter/Components/chapter_item.component.dart';

// import '../Model/novel/chapter.model.dart';
import '../Model/novel/novel.model.dart';

class NovelDetails extends StatelessWidget {
  const NovelDetails({required this.novel, super.key});

  final Novel novel;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            LayoutGrid(
              columnSizes: [1.fr, 2.fr],
              rowSizes: const [auto],
              columnGap: 10,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                      image: NetworkImage(novel.coverUrl), fit: BoxFit.fill),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(novel.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.normal),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis),
                    Text(
                      novel.authors.join(", "),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text("${novel.status} | ${novel.sourceName}"),
                  ],
                )
              ],
            ),
            novel.alternateTitles != null && novel.alternateTitles!.isNotEmpty
                ? Text("alternate titles: ${novel.alternateTitles!.join(", ")}")
                : const SizedBox.shrink(),
            novel.genres != null && novel.genres!.isNotEmpty
                ? Text("genres: ${novel.genres!.join(", ")}")
                : const SizedBox.shrink(),
            novel.genres != null && novel.genres!.isNotEmpty
                ? Container(
                    height: 32,
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: novel.genres!.length,
                        itemBuilder: ((context, index) {
                          return GenreTag(labelText: novel.genres![index]);
                        })))
                : const SizedBox.shrink(),
            // Text("description: ${novel.description}"),

            // RichText(
            //   text: TextSpan(children: [
            //     const TextSpan(
            //         text: "Description: ",
            //         style: TextStyle(fontWeight: FontWeight.bold)),
            //     TextSpan(text: novel.description)
            //   ]),
            //   maxLines: 5,
            // ),
            TextClosed(text: novel.description)
          ],
        ));
  }
}
