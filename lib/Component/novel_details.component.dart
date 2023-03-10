import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
                  child: CachedNetworkImage(
                      imageUrl: novel.coverUrl,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        );
                      },
                      errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                      imageBuilder: (context, imageProvider) => Image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          )),
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
                ? Text("Alternate Titles: ${novel.alternateTitles!.join(", ")}")
                : const SizedBox.shrink(),
            novel.genres != null && novel.genres!.isNotEmpty
                ? Container(
                    height: 48,
                    padding: const EdgeInsets.all(8),
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: novel.genres!.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 8);
                        },
                        itemBuilder: ((context, index) {
                          return GenreTag(labelText: novel.genres![index]);
                        })))
                : const SizedBox.shrink(),
            // Text("description: ${novel.description}"),

            TextClosed(labelText: "Description:", text: novel.description)
          ],
        ));
  }
}
