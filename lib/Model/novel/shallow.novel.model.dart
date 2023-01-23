/// ShallowNovel is a model that contains only the basic information of a novel.
class ShallowNovel {
  String? title, coverUrl, sourceUrl;
  ShallowNovel({this.title, this.coverUrl, this.sourceUrl});

  @override
  String toString() {
    return 'ShallowNovel(title: $title, coverUrl: $coverUrl, sourceUrl: $sourceUrl\n)';
  }
}
