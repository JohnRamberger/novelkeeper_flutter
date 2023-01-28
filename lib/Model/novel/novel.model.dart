import 'package:hive/hive.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';
import 'package:novelkeeper_flutter/Model/novel/chapter.model.dart';

part 'novel.model.g.dart';

@HiveType(typeId: 0)

/// Novel is a model that contains all the information of a novel.
class Novel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String coverUrl;
  @HiveField(3)
  String sourceUrl;
  @HiveField(4)
  String status;
  @HiveField(5)
  String sourceName;
  @HiveField(6)
  List<String> authors;
  @HiveField(7)
  List<String>? alternateTitles = [];
  @HiveField(8)
  List<String>? genres = [];
  @HiveField(9)
  bool isFavorite;
  @HiveField(10)
  List<Chapter> chapters = [];

  
  Novel(
      {required this.title,
      required this.authors,
      required this.description,
      required this.coverUrl,
      required this.sourceUrl,
      required this.status,
      required this.chapters,
      required this.sourceName,
      this.alternateTitles,
      this.genres,
      this.isFavorite = false});

  Novel.fromShallow(
      {required ShallowNovel shallowNovel,
      required this.authors,
      required this.description,
      required this.status,
      required this.chapters,
      required this.sourceName,
      this.alternateTitles,
      this.genres,
      this.isFavorite = false})
      : title = shallowNovel.title,
        coverUrl = shallowNovel.coverUrl,
        sourceUrl = shallowNovel.sourceUrl;

  @override
  String toString() {
    return "Novel(title: $title, authors: $authors, status: $status, description: ${description.substring(0, 50 > description.length ? description.length : 50)}, coverUrl: $coverUrl, sourceUrl: $sourceUrl, genres: $genres, chapters: ${chapters.length}, isFavorite: $isFavorite)";
  }
}
