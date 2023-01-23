import 'package:novelkeeper_flutter/Model/source.model.dart';
import 'package:novelkeeper_flutter/Model/novel/chapter.model.dart';

class Novel {
  String? title, author, description, coverUrl, sourceUrl;
  List<String>? genres;
  Source? source;
  List<Chapter>? chapters;
  bool isFavorite = false;
  Novel(
      {this.title,
      this.author,
      this.description,
      this.coverUrl,
      this.sourceUrl,
      this.genres,
      this.source,
      this.chapters,
      this.isFavorite = false});
}
