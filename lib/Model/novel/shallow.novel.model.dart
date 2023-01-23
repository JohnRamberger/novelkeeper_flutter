/// ShallowNovel is a model that contains only the basic information of a novel.
class ShallowNovel {
  String title, coverUrl, sourceUrl;
  ShallowNovel(
      {required this.title, required this.coverUrl, required this.sourceUrl});

  @override
  String toString() {
    return 'ShallowNovel(title: $title, coverUrl: $coverUrl, sourceUrl: $sourceUrl\n)';
  }
}
