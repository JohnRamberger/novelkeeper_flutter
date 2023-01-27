import 'dart:ffi';

import 'package:flutter/cupertino.dart';
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

  /// The cached chapters
  final List<Chapter> _cachedChapters = [];

  /// The shallow novel that is passed to this view
  final ShallowNovel shallowNovel;

  NovelDetailsViewModel({required this.shallowNovel}) {
    _checkForCacheOrLoad();
  }

  Future _checkForCacheOrLoad() async {
    // check for cached novel
    NovelProvider novelProvider = NovelProvider();
    await novelProvider.open(NKConfig.dbPath);

    Novel cachedNovel =
        await novelProvider.getNovelBySourceUrl(shallowNovel.sourceUrl);

    if (cachedNovel.id != null && cachedNovel.id! > 0) {
      print("novel is cached");
      // novel is cached
      novel = cachedNovel;
      _novelFound(novel, cache: false);
      // check for cached chapters
    } else {
      print("novel is not cached");
      // novel is not cached
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
    ChapterProvider chapterProvider = ChapterProvider();
    await chapterProvider.open();

    for (var chapter in novel.chapters) {
      // check if chapter is already cached
      Chapter cached = await chapterProvider.getChapterByUrl(chapter.sourceUrl);
      if (cached.id != null && cached.id! > 0) {
        // chapter already cached - update
        chapter.id = cached.id;
        await chapterProvider.update(chapter);
        _cachedChapters.add(chapter);
      } else {
        // chapter not cached - insert
        _cachedChapters.add(await chapterProvider.insert(chapter));
      }
    }
    // cache novel
    // add list of cached chapters' ids to novel

    NovelProvider novelProvider = NovelProvider();
    await novelProvider.open(NKConfig.dbPath);
    // check if novel is already cached
    Novel cached = await novelProvider.getNovelBySourceUrl(novel.sourceUrl);
    if (cached.id != null && cached.id! > 0) {
      // novel already cached - update
      novel.id = cached.id;
      await novelProvider.update(novel);
    } else {
      // novel not cached - insert
      await novelProvider.insert(novel);
    }
  }
}
