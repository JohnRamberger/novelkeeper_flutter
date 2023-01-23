/// ShallowNovel is a model that contains only the basic information of a novel.
class ShallowNovel {
  String? title, coverUrl, sourceUrl;
  ShallowNovel({this.title, this.coverUrl, this.sourceUrl});

  @override
  String toString() {
    return 'ShallowNovel(\n\ttitle: $title, \n\tcoverUrl: $coverUrl, \n\tsourceUrl: $sourceUrl\n)';
  }
}
