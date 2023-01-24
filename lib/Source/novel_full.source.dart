// import 'package:http/http.dart';
import 'package:intersperse/intersperse.dart';
import 'package:novelkeeper_flutter/Config/config.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';
import 'package:novelkeeper_flutter/Model/results/search_result.model.dart';
import 'package:novelkeeper_flutter/Model/source.model.dart';
import 'package:novelkeeper_flutter/Model/scrape_job.model.dart';
import 'package:novelkeeper_flutter/utils/Url/url.dart';

import '../Model/novel/chapter.model.dart';
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

    // get the novel chapters
    List<Chapter> chapters =
        await getNovelChaptersJob(job: job, shallow: novel);

    // get the novel details
    var details = selectorNovelDetails(job, novel, chapters);

    return details;
  }

  @override
  Future<List<Chapter>> getNovelChaptersJob(
      {required ScrapeJob job, required ShallowNovel shallow}) async {
    // get the chapters from the current page first using selectors
    List<Chapter> chapterList = selectorNovelChapters(job, 0);

    // get the href of the last page
    var lastPage =
        job.document.querySelector("div.row + ul.pagination > li.last > a");
    if (lastPage == null) {
      // no last page, so we're done
      return chapterList;
    }
    var lastPageHref = lastPage.attributes["href"];
    // int currentPageIndex = 2;
    int lastPageIndex = int.parse(lastPageHref.split("=").last ?? "0");
    int chaptersFound = chapterList.length;
    for (var i = 2; i <= lastPageIndex; i++) {
      // make a new sourcejob
      var newJob = ScrapeJob(url: "${shallow.sourceUrl}?page=$i");
      await NKConfig.scrapeClient.startJob(newJob);
      List<Chapter> newChapters = selectorNovelChapters(newJob, chaptersFound);
      chapterList = chapterList + newChapters;
      chaptersFound += newChapters.length;
    }

    return chapterList;
  }

  @override
  List<Chapter> selectorNovelChapters(ScrapeJob job, int chaptersFound) {
    var chapterSectionElements =
        job.document.querySelectorAll("ul.list-chapter");

    List<dynamic> chapterElements = [];
    for (var c in chapterSectionElements) {
      List<dynamic> a = c.querySelectorAll("li > a");
      if (a.isNotEmpty) {
        chapterElements = chapterElements + a;
      }
    }

    List<Chapter> chapterList = [];
    for (var c in chapterElements) {
      String title = c.text;
      String sourceUrl = c.attributes["href"] ?? "";
      sourceUrl = getFullUrl(baseUrl, sourceUrl);
      int index = chaptersFound++;
      chapterList
          .add(Chapter(title: title, sourceUrl: sourceUrl, index: index));
    }

    return chapterList;
  }

  @override
  Novel selectorNovelDetails(
      ScrapeJob job, ShallowNovel shallow, List<Chapter> chapters) {
    // already have title, sourceURl and coverUrl
    // need to replace coverUrl (due to image being shit)
    var coverUrl = job.document
            .querySelector(
                "#truyen > div.csstransforms3d > div > div.col-xs-12.col-info-desc > div.col-xs-12.col-sm-4.col-md-4.info-holder > div.books > div.book > img")
            ?.attributes["src"] ??
        "";
    coverUrl = getFullUrl(baseUrl, coverUrl);

    var authors =
        job.document.querySelectorAll("div.info > div:first-child > a");
    List<String> authorList = [];
    for (var a in authors) {
      authorList.add(a.text);
    }

    var descriptionList = job.document.querySelectorAll(
        "#truyen > div.csstransforms3d > div > div.col-xs-12.col-info-desc > div.col-xs-12.col-sm-8.col-md-8.desc > div.desc-text > p");

    String description = descriptionList.map((x) => x.text).join("\n\n");

    var alternateTitles =
        job.document.querySelector("div.info > div:nth-child(1)");
    List<String> alternateTitleList = [];
    if (alternateTitles != null) {
      alternateTitles.querySelector("h3")?.remove();
      if ((alternateTitles.text as String).contains(",")) {
        alternateTitleList = alternateTitles.text.split(",");
      } else {
        alternateTitleList = [alternateTitles.text];
      }
    }

    var genres =
        job.document.querySelectorAll("div.info > div:nth-child(2) > a");
    List<String> genreList = [];
    for (var g in genres) {
      genreList.add(g.text);
    }

    var status =
        job.document.querySelector("div.info > div:nth-child(4) > a")?.text;

    var novel = Novel.fromShallow(
        shallowNovel: shallow,
        sourceName: name,
        authors: authorList,
        status: status,
        description: description,
        alternateTitles: alternateTitleList,
        genres: genreList,
        chapters: chapters);

    novel.coverUrl = coverUrl;
    return novel;
  }

  // ---------- Content ----------

  @override
  Future<Chapter> getChapterContentJob(Chapter chapter) async {
    // make the job
    var job = ScrapeJob(url: chapter.sourceUrl);
    await NKConfig.scrapeClient.startJob(job);

    // get the chapter content
    var content = selectorChapterContent(job, chapter);

    chapter.content = content;
    return chapter;
  }

  @override
  String selectorChapterContent(ScrapeJob job, Chapter chapter) {
    // TODO: implement selectorChapterContent
    throw UnimplementedError();
  }
}
