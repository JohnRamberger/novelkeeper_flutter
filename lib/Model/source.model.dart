import 'package:novelkeeper_flutter/Model/scrape_job.model.dart';

enum SearchType { POPULAR, NEW, QUERY, FILTER }

abstract class Source {
  /// The name of the source
  String? name;

  /// The baseurl of the source
  String? baseUrl;

  /// Get the list of novels from the source
  /// @param page The page number to get
  /// @param query The query to search for
  /// @return ScrapeJob
  ScrapeJob searchNovelJob({required int page, required String query});
}
