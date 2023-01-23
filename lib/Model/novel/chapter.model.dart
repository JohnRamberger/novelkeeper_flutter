class Chapter {
  String title, sourceUrl;
  int? index;
  bool? isRead;
  bool? bookmarked;
  Chapter(
      {required this.title,
      required this.sourceUrl,
      this.index,
      this.isRead = false,
      this.bookmarked = false});
}
