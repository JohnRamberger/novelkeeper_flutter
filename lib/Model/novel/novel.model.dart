import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';
import 'package:novelkeeper_flutter/Model/source.model.dart';
import 'package:novelkeeper_flutter/Model/novel/chapter.model.dart';

/// Novel is a model that contains all the information of a novel.
class Novel {
  String title, description, coverUrl, sourceUrl;
  List<String> authors;
  List<String>? alternateTitles = [];
  List<String>? genres = [];
  List<Chapter>? chapters = [];
  bool isFavorite;
  Novel(
      {required this.title,
      required this.authors,
      required this.description,
      required this.coverUrl,
      required this.sourceUrl,
      this.alternateTitles,
      this.genres,
      this.chapters,
      this.isFavorite = false});

  Novel.fromShallow(
      {required ShallowNovel shallowNovel,
      required this.authors,
      required this.description,
      this.alternateTitles,
      this.genres,
      this.chapters,
      this.isFavorite = false})
      : title = shallowNovel.title,
        coverUrl = shallowNovel.coverUrl,
        sourceUrl = shallowNovel.sourceUrl;

  @override
  String toString() {
    return "Novel(title: $title, authors: $authors, description: ${description.substring(0, 50 > description.length ? description.length : 50)}, coverUrl: $coverUrl, sourceUrl: $sourceUrl, genres: $genres, chapters: $chapters, isFavorite: $isFavorite)";
  }
}
