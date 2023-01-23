import 'package:http/http.dart';
import 'package:novelkeeper_flutter/Config/config.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';
import 'package:novelkeeper_flutter/Model/results/search_result.model.dart';
import 'package:novelkeeper_flutter/Model/source.model.dart';
import 'package:novelkeeper_flutter/Model/scrape_job.model.dart';
import 'package:novelkeeper_flutter/utils/Url/url.dart';

import '../Model/novel/novel.model.dart';

class NovelFull extends Source {
  NovelFull() {
    name = "NovelFull";
    baseUrl = "https://novelfull.com";
  }

  @override
  Future<SearchResult> searchNovelJob(
      {required String query, int page = -1}) async {
    String url =
        "$baseUrl/search?keyword=$query${page > 0 ? "&page=$page" : ""}";
    // make the job
    var job = ScrapeJob(url: url);
    return await listNovelJob(job);
  }

  @override
  Future<SearchResult> listNovelJob(ScrapeJob job) async {
    await NKConfig.scrapeClient.startJob(job);

    // get list of novels
    var novels = selectorNovelsFromSearch(job);

    return novels;
  }

  @override
  SearchResult selectorNovelsFromSearch(ScrapeJob job) {
    // get the list of novels
    var novels = job.document.querySelectorAll(
        "#list-page > div.col-xs-12.col-sm-12.col-md-9.col-truyen-main.archive > div > div.row");
    if (novels.length <= 0) {
      return SearchResult(novels: []);
    }
    List<ShallowNovel> novelList = [];
    for (var n in novels) {
      var novel = selectorShallowNovel(n);
      novelList.add(novel);
    }
    // check for extra pages
    var lastPage = job.document.querySelector(
        "#container > div.container.text-center.pagination-container > div > ul > li.last > a");

    var pageCount = 0;
    if (lastPage != null) {
      var href = lastPage.attributes["href"];
      if (href != null && href.isNotEmpty) {
        // get the page count
        pageCount = int.parse(href.split("=").last ?? "0");
      }
    }

    return SearchResult(novels: novelList, pageCount: pageCount);
  }

  @override
  ShallowNovel selectorShallowNovel(element) {
    // get the title
    var title =
        element.querySelector("div.col-xs-7 > div > h3 > a")?.text ?? "";

    // get the cover url
    var coverUrl =
        element.querySelector("div.col-xs-3 > div > img")?.attributes["src"] ??
            "";

    // check if the cover url is relative
    coverUrl = getFullUrl(baseUrl, coverUrl ?? "");

    // get the novel url
    var sourceUrl = element
            .querySelector("div.col-xs-7 > div > h3 > a")
            ?.attributes["href"] ??
        "";

    // check if the novel url is relative
    sourceUrl = getFullUrl(baseUrl, sourceUrl ?? "");

    return ShallowNovel(title: title, coverUrl: coverUrl, sourceUrl: sourceUrl);
  }

  // ---------- Details ----------

  @override
  Future<Novel> getNovelDetailsJob(ShallowNovel novel) async {
    // make the job
    var job = ScrapeJob(url: novel.sourceUrl);
    await NKConfig.scrapeClient.startJob(job);

    // get the novel details
    var details = selectorNovelDetails(job, novel);

    return details;
  }

  @override
  Novel selectorNovelDetails(ScrapeJob job, ShallowNovel shallow) {
    // already have title, sourceURl and coverUrl
    // need to replace coverUrl (due to image being shit)
    var coverUrl = job.document
            .querySelector(
                "#truyen > div.csstransforms3d > div > div.col-xs-12.col-info-desc > div.col-xs-12.col-sm-4.col-md-4.info-holder > div.books > div.book > img")
            ?.attributes["src"] ??
        "";

    var authors = job.document.querySelectorAll(
        "#truyen > div.csstransforms3d > div > div.col-xs-12.col-info-desc > div.col-xs-12.col-sm-4.col-md-4.info-holder > div.info > div:nth-child(1) > a");

    if (authors.length > 0) {
      authors = authors.map((x) => x.text).toList();
    } else {
      authors = [];
    }

    var description = job.document.querySelector(
        "#truyen > div.csstransforms3d > div > div.col-xs-12.col-info-desc > div.col-xs-12.col-sm-8.col-md-8.desc > div.desc-text");

    var novel = Novel.fromShallow(
        shallowNovel: shallow, authors: authors, description: description);

    novel.coverUrl = coverUrl;
    return novel;
  }
}
