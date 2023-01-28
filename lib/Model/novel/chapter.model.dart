import 'package:hive/hive.dart';

part 'chapter.model.g.dart';

@HiveType(typeId: 1)
class Chapter extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String sourceUrl;
  @HiveField(2)
  int index;
  @HiveField(3)
  bool isRead;
  @HiveField(4)
  bool isBookmarked;
  @HiveField(5)
  bool isDownloaded;
  @HiveField(6)
  dynamic content;
  
  Chapter(
      {required this.title,
      required this.sourceUrl,
      required this.index,
      this.isRead = false,
      this.isBookmarked = false,
      this.isDownloaded = false});

  Chapter.withContent({
    required this.title,
    required this.sourceUrl,
    required this.index,
    required this.content,
    this.isRead = false,
    this.isBookmarked = false,
    this.isDownloaded = false,
  });
}
