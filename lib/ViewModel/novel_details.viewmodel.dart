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
    // TODO: check cache first
    _loadNovel();
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
        this.novel = novel;
        chaptersRev = novel.chapters.reversed.toList();
        isLoading = false;
        if (_mounted) notifyListeners();

        // cache novel chapters
        ChapterProvider chapterProvider = ChapterProvider();
        chapterProvider.open(NKConfig.dbPath);

        for (var chapter in novel.chapters) {
          // check if chapter is already cached
          Chapter cached =
              await chapterProvider.getChapterByUrl(chapter.sourceUrl);
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
        // TODO: cache novel
        // add list of cached chapters' ids to novel

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
}
