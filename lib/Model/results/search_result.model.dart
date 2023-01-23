import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';

class SearchResult {
  List<ShallowNovel> novels;
  int pageCount;

  SearchResult({required this.novels, this.pageCount = 0});

  @override
  String toString() {
    return 'SearchResult(novels: \n$novels, \npageCount: $pageCount)';
  }
}
