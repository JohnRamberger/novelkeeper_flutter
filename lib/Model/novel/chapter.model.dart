import 'package:sqflite/sqflite.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'sourceUrl': sourceUrl,
      'index': index,
      'isRead': isRead == true ? 1 : 0,
      'bookmarked': isBookmarked == true ? 1 : 0,
      'isDownloaded': isDownloaded == true ? 1 : 0,
    };
  }
}

//   CREATE TABLE chapter (
// 	"_id"                TEXT(100) NOT NULL  PRIMARY KEY  ,
// 	title                TEXT NOT NULL    ,
// 	sourceUrl            TEXT NOT NULL    ,
// 	index                INTEGER  DEFAULT -1   ,
// 	isRead               BOOLEAN  DEFAULT false   ,
// 	isBookmarked         BOOLEAN  DEFAULT false   ,
// 	isDownloaded         BOOLEAN  DEFAULT false
//  );

// define sqlite table and column names
const String tableName = 'chapter';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnSourceUrl = 'sourceUrl';
const String columnIndex = 'index';
const String columnIsRead = 'isRead';
const String columnIsBookmarked = 'isBookmarked';
const String columnIsDownloaded = 'isDownloaded';

class ChapterProvider {
  late Database db;
  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $tableName (
            "$columnId"                INTEGER PRIMARY KEY AUTOINCREMENT  ,
            $columnTitle                TEXT NOT NULL    ,
            $columnSourceUrl            TEXT NOT NULL    ,
            $columnIndex                INTEGER  DEFAULT -1   ,
            $columnIsRead               BOOLEAN  DEFAULT false   ,
            $columnIsBookmarked         BOOLEAN  DEFAULT false   ,
            $columnIsDownloaded         BOOLEAN  DEFAULT false
          )
          ''');
    });
  }

  Future<Chapter> insert(Chapter chapter) async {
    chapter.id = await db.insert(tableName, chapter.toMap());
    return chapter;
  }

  Future<Chapter> getChapter(int id) async {
    List<Map> maps = await db.query(tableName,
        columns: [
          columnId,
          columnTitle,
          columnSourceUrl,
          columnIndex,
          columnIsRead,
          columnIsBookmarked,
          columnIsDownloaded
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Chapter(
          title: maps.first[columnTitle],
          sourceUrl: maps.first[columnSourceUrl],
          index: maps.first[columnIndex],
          isRead: maps.first[columnIsRead] == 1,
          isBookmarked: maps.first[columnIsBookmarked] == 1,
          isDownloaded: maps.first[columnIsDownloaded] == 1);
    }
    return Chapter(
      title: '',
      sourceUrl: '',
      index: -1,
    );
  }

  Future<Chapter> getChapterByUrl(String sourceUrl) async {
    // get the chapter by sourceUrl
    List<Map> maps = await db.query(tableName,
        columns: [
          columnId,
          columnTitle,
          columnSourceUrl,
          columnIndex,
          columnIsRead,
          columnIsBookmarked,
          columnIsDownloaded
        ],
        where: '$columnSourceUrl = ?',
        whereArgs: [sourceUrl]);
    if (maps.isNotEmpty) {
      return Chapter(
          title: maps.first[columnTitle],
          sourceUrl: maps.first[columnSourceUrl],
          index: maps.first[columnIndex],
          isRead: maps.first[columnIsRead] == 1,
          isBookmarked: maps.first[columnIsBookmarked] == 1,
          isDownloaded: maps.first[columnIsDownloaded] == 1);
    }
    return Chapter(
      title: '',
      sourceUrl: '',
      index: -1,
    );
  }

  Future<int> delete(int id) async {
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Chapter chapter) async {
    return await db.update(tableName, chapter.toMap(),
        where: '$columnId = ?', whereArgs: [chapter.id]);
  }

  Future close() async => db.close();
}
