import 'package:novelkeeper_flutter/Model/source.model.dart';
import '../Model/scrape_job.model.dart';

class NovelFull extends Source {
  NovelFull() {
    name = "NovelFull";
    baseUrl = "https://novelfull.com";
  }

  @override
  ScrapeJob searchNovelJob({required int page, required String query}) {
    throw UnimplementedError();
  }
}
