import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';
import 'package:novelkeeper_flutter/Model/source.model.dart';
import 'package:novelkeeper_flutter/Model/novel/chapter.model.dart';

/// Novel is a model that contains all the information of a novel.
class Novel {
  String title, description, coverUrl, sourceUrl;
  List<String> authors;
  List<String>? genres;
  List<Chapter>? chapters;
  bool isFavorite = false;
  Novel(
      {required this.title,
      required this.authors,
      required this.description,
      required this.coverUrl,
      required this.sourceUrl,
      this.genres,
      this.chapters,
      this.isFavorite = false});

  Novel.fromShallow(
      {required ShallowNovel shallowNovel,
      required this.authors,
      required this.description,
      this.genres,
      this.chapters,
      this.isFavorite = false})
      : title = shallowNovel.title,
        coverUrl = shallowNovel.coverUrl,
        sourceUrl = shallowNovel.sourceUrl;
}
