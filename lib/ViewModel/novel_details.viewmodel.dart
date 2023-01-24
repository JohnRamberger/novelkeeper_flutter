import 'package:flutter/cupertino.dart';
import 'package:novelkeeper_flutter/Model/novel/chapter.model.dart';
import 'package:novelkeeper_flutter/Model/novel/novel.model.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';

import '../Source/novel_full.source.dart';
import '../utils/Url/url.dart';

class NovelDetailsViewModel extends ChangeNotifier {
  bool isLoading = true;

  late Novel novel;
  List<Chapter> chaptersRev = [];

  final ShallowNovel shallowNovel;

  NovelDetailsViewModel({required this.shallowNovel}) {
    _loadNovel();
  }

  void reload() {
    _loadNovel();
  }

  void _loadNovel() async {
    switch (getBaseUrl(shallowNovel.sourceUrl)) {
      case "https://novelfull.com":
        var novel = await NovelFull().getNovelDetailsJob(shallowNovel);
        this.novel = novel;
        chaptersRev = novel.chapters.reversed.toList();
        isLoading = false;
        notifyListeners();
        break;
      default:
        throw Exception("Unknown source");
    }
  }
}
