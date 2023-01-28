class Chapter {
  int? id;
  String title, sourceUrl;
  int index;
  bool isRead;
  bool isBookmarked;
  bool isDownloaded;
  dynamic content;
  Chapter(
      {required this.title,
      required this.sourceUrl,
      required this.index,
      this.isRead = false,
      this.isBookmarked = false,
      this.isDownloaded = false,
      this.id});

  Chapter.withContent({
    required this.title,
    required this.sourceUrl,
    required this.index,
    required this.content,
    this.isRead = false,
    this.isBookmarked = false,
    this.isDownloaded = false,
    this.id,
  });
}