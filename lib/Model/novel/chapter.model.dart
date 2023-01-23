class Chapter {
  String title, sourceUrl;
  int index;
  bool? isRead;
  bool? bookmarked;
  bool? isDownloaded;
  dynamic content;
  Chapter(
      {required this.title,
      required this.sourceUrl,
      required this.index,
      this.isRead = false,
      this.bookmarked = false,
      this.isDownloaded = false});

  Chapter.withContent({
    required this.title,
    required this.sourceUrl,
    required this.index,
    required this.content,
    this.isRead = false,
    this.bookmarked = false,
    this.isDownloaded = false,
  });
}
