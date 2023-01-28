import 'package:novelkeeper_flutter/Config/config.dart';

// define sqlite table and column names
const String tableName = 'chapter';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnSourceUrl = 'sourceUrl';
const String columnIndex = 'listIndex';
const String columnIsRead = 'isRead';
const String columnIsBookmarked = 'isBookmarked';
const String columnIsDownloaded = 'isDownloaded';

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

  // Map<String, dynamic> toMap() {
  //   return {
  //     columnId: id,
  //     columnTitle: title,
  //     columnSourceUrl: sourceUrl,
  //     columnIndex: index,
  //     columnIsRead: isRead == true ? 1 : 0,
  //     columnIsBookmarked: isBookmarked == true ? 1 : 0,
  //     columnIsDownloaded: isDownloaded == true ? 1 : 0,
  //   };
  // }

  // factory Chapter.fromMap(Map<dynamic, dynamic> map) {
  //   return Chapter(
  //     id: map[columnId],
  //     title: map[columnTitle],
  //     sourceUrl: map[columnSourceUrl],
  //     index: map[columnIndex],
  //     isRead: map[columnIsRead] == 1,
  //     isBookmarked: map[columnIsBookmarked] == 1,
  //     isDownloaded: map[columnIsDownloaded] == 1,
  //   );
  // }
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

// class ChapterProvider {
//   late Database _db;

//   /// Open the database
//   /// @return the opened database
//   Future open() async {
//     _db = await NKConfig.openDB();
//   }

//   /// The initial script to create the table
//   static String initialScript = '''
//           CREATE TABLE $tableName (
//             "$columnId"                INTEGER PRIMARY KEY AUTOINCREMENT  ,
//             $columnTitle                TEXT NOT NULL    ,
//             $columnSourceUrl            TEXT NOT NULL    ,
//             $columnIndex                INTEGER  DEFAULT -1   ,
//             $columnIsRead               BOOLEAN  DEFAULT false   ,
//             $columnIsBookmarked         BOOLEAN  DEFAULT false   ,
//             $columnIsDownloaded         BOOLEAN  DEFAULT false
//           )
//           ''';

//   /// Insert a chapter into the database
//   /// @param chapter the chapter to insert
//   /// @return the inserted chapter
//   Future<Chapter> insert(Chapter chapter) async {
//     chapter.id = await _db.insert(tableName, chapter.toMap());
//     return chapter;
//   }

//   /// Get a chapter by id
//   /// @param id the id of the chapter to get
//   /// @return the chapter with the given id
//   Future<Chapter> getChapter(int id) async {
//     List<Map> maps = await _db.query(tableName,
//         columns: [
//           columnId,
//           columnTitle,
//           columnSourceUrl,
//           columnIndex,
//           columnIsRead,
//           columnIsBookmarked,
//           columnIsDownloaded
//         ],
//         where: '$columnId = ?',
//         whereArgs: [id]);
//     if (maps.isNotEmpty) {
//       return Chapter.fromMap(maps.first);
//     }
//     return Chapter(
//       title: '',
//       sourceUrl: '',
//       index: -1,
//     );
//   }

//   /// Get a chapter by sourceUrl
//   /// @param sourceUrl the sourceUrl of the chapter to get
//   /// @return the chapter with the given sourceUrl
//   Future<Chapter> getChapterByUrl(String sourceUrl) async {
//     // get the chapter by sourceUrl
//     List<Map> maps = await _db.query(tableName,
//         columns: [
//           columnId,
//           columnTitle,
//           columnSourceUrl,
//           columnIndex,
//           columnIsRead,
//           columnIsBookmarked,
//           columnIsDownloaded
//         ],
//         where: '$columnSourceUrl = ?',
//         whereArgs: [sourceUrl]);
//     if (maps.isNotEmpty) {
//       return Chapter.fromMap(maps.first);
//     }
//     return Chapter(
//       title: '',
//       sourceUrl: '',
//       index: -1,
//     );
//   }

//   /// Delete a chapter by id
//   /// @param id the id of the chapter to delete
//   /// @return the number of rows deleted
//   Future<int> delete(int id) async {
//     return await _db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
//   }

//   /// Update a chapter
//   /// @param chapter the chapter to update
//   /// @return the number of rows updated
//   Future<int> update(Chapter chapter) async {
//     return await _db.update(tableName, chapter.toMap(),
//         where: '$columnId = ?', whereArgs: [chapter.id]);
//   }

//   /// Close the database
//   Future close() async => _db.close();
// }
