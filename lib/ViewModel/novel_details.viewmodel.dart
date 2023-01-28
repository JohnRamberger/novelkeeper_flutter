import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:novelkeeper_flutter/Config/config.dart';
import 'package:novelkeeper_flutter/Model/novel/chapter.model.dart';
import 'package:novelkeeper_flutter/Model/novel/novel.model.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';

import '../Source/novel_full.source.dart';
import '../utils/Url/url.dart';

/// This class is responsible for loading the novel details
/// and passing it to the view
class NovelDetailsViewModel extends ChangeNotifier {
  /// This is used to prevent calling notifyListeners() after dispose()
  bool _mounted = true;

  /// Whether this provider is mounted
  bool get mounted => _mounted;

  /// Whether the novel is still loading
  bool isLoading = true;

  /// The novel after it is loaded
  late Novel novel;

  /// The chapters in reverse order
  List<Chapter> chaptersRev = [];

  /// The shallow novel that is passed to this view
  final ShallowNovel shallowNovel;

  NovelDetailsViewModel({required this.shallowNovel}) {
    _checkForCacheOrLoad();
  }

  Future _checkForCacheOrLoad() async {
    var cacheBox = await Hive.openBox<Novel>(NKConfig.boxNovelCache);
    Novel? cached = cacheBox.get(shallowNovel.sourceUrl);

    if (cached != null) {
      // novel is cached
      // print("novel is cached");
      novel = cached;
      _novelFound(novel, cache: false);
    } else {
      // novel is not cached
      // print("novel is not cached");
      _loadNovel();
    }
  }

  /// Reloads the novel from the source
  void reload() {
    isLoading = true;
    if (_mounted) notifyListeners();
    _loadNovel();
  }

  /// Loads the novel from the source
  void _loadNovel() async {
    switch (getBaseUrl(shallowNovel.sourceUrl)) {
      case "https://novelfull.com":
        var novel = await NovelFull().getNovelDetailsJob(shallowNovel);
        _novelFound(novel);
        break;
      default:
        throw Exception("Unknown source");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  Future _novelFound(Novel novel, {bool cache = true}) async {
    this.novel = novel;
    chaptersRev = novel.chapters.reversed.toList();
    isLoading = false;
    if (_mounted) notifyListeners();

    // cache novel

    if (cache) _cacheNovel(novel);
  }

  Future _cacheNovel(Novel novel) async {
    // cache novel chapters
    var cacheBox = await Hive.openBox<Novel>(NKConfig.boxNovelCache);
    cacheBox.put(novel.sourceUrl, novel);
  }
}
