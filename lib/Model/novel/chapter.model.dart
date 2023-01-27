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
const int dbVersion = 1;

class ChapterProvider {
  late Database _db;

  /// Open the database
  /// @param path the path to the database
  /// @return the database
  Future open(String path) async {
    _db = await openDatabase(path, version: 1,
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
      version = dbVersion;
    });
  }

  /// Insert a chapter into the database
  /// @param chapter the chapter to insert
  /// @return the inserted chapter
  Future<Chapter> insert(Chapter chapter) async {
    chapter.id = await _db.insert(tableName, chapter.toMap());
    return chapter;
  }

  /// Get a chapter by id
  /// @param id the id of the chapter to get
  /// @return the chapter with the given id
  Future<Chapter> getChapter(int id) async {
    List<Map> maps = await _db.query(tableName,
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

  /// Get a chapter by sourceUrl
  /// @param sourceUrl the sourceUrl of the chapter to get
  /// @return the chapter with the given sourceUrl
  Future<Chapter> getChapterByUrl(String sourceUrl) async {
    // get the chapter by sourceUrl
    List<Map> maps = await _db.query(tableName,
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

  /// Delete a chapter by id
  /// @param id the id of the chapter to delete
  /// @return the number of rows deleted
  Future<int> delete(int id) async {
    return await _db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  /// Update a chapter
  /// @param chapter the chapter to update
  /// @return the number of rows updated
  Future<int> update(Chapter chapter) async {
    return await _db.update(tableName, chapter.toMap(),
        where: '$columnId = ?', whereArgs: [chapter.id]);
  }

  /// Close the database
  Future close() async => _db.close();
}
