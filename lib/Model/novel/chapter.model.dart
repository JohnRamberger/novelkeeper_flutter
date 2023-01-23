class Chapter {
  String? title, url;
  int? index;
  bool? isRead;
  bool? bookmarked;
  Chapter(
      {this.title,
      this.url,
      this.index,
      this.isRead = false,
      this.bookmarked = false});
}
