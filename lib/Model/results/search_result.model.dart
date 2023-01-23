import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';

class SearchResult {
  List<ShallowNovel> novels;
  List<String>? pageUrls;

  SearchResult({required this.novels, this.pageUrls});

  @override
  String toString() {
    return 'SearchResult(novels: \n$novels, \npageUrls: $pageUrls)';
  }
}
