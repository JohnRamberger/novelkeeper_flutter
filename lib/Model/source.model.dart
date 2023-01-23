import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';
import 'package:novelkeeper_flutter/Model/results/search_result.model.dart';
import 'package:novelkeeper_flutter/Model/scrape_job.model.dart';

import 'novel/novel.model.dart';

enum SearchType { POPULAR, NEW, QUERY, FILTER }

abstract class Source {
  /// The name of the source
  String name = "";

  /// The baseurl of the source
  String baseUrl = "";

  // ---------- Search ----------

  /// Get the list of novels from the source
  /// @param page The page number to get
  /// @param query The query to search for
  /// @return ScrapeJob
  Future<SearchResult> searchNovelJob(
      {required int page, required String query});

  /// Get the list of novels from the source (whether that be search, list, or filter)
  Future<SearchResult> listNovelJob(ScrapeJob job);

  /// selector - Get the list of novels from the search job
  SearchResult selectorNovelsFromSearch(ScrapeJob job);

  /// selector - Get the novel from html element
  ShallowNovel selectorShallowNovel(dynamic element);

  // ---------- Details ----------

  /// Get the novel details from the source
  Future<Novel> getNovelDetailsJob(ShallowNovel novel);

  /// selector - Get the novel details from the job
  /// @param job The scrape job
  /// @param shallow The shallow novel
  /// @return Novel
  Novel selectorNovelDetails(ScrapeJob job, ShallowNovel shallow);

  // ---------- Content ----------
}
