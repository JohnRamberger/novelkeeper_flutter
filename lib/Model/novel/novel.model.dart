import 'package:novelkeeper_flutter/Config/config.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';
import 'package:novelkeeper_flutter/Model/novel/chapter.model.dart';
import 'package:sqflite/sqflite.dart';

// define sqlite table and column names
const String tableName = 'novel';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnSourceUrl = 'sourceUrl';
const String columnCoverUrl = 'coverUrl';
const String columnDescription = 'description';
const String columnStatus = 'status';
const String columnAuthors = 'authors';
const String columnAlternateTitles = 'alternateTitles';
const String columnGenres = 'genres';
const String columnChapters = 'chapters';
const String columnSourceName = 'sourceName';
const String columnIsFavorite = 'isFavorite';
const int dbVersion = 1;

/// Novel is a model that contains all the information of a novel.
class Novel {
  int? id;
  String title, description, coverUrl, sourceUrl, status, sourceName;
  List<String> authors;
  List<String>? alternateTitles = [];
  List<String>? genres = [];
  List<Chapter> chapters = [];
  bool isFavorite;
  Novel(
      {required this.title,
      required this.authors,
      required this.description,
      required this.coverUrl,
      required this.sourceUrl,
      required this.status,
      required this.chapters,
      required this.sourceName,
      this.alternateTitles,
      this.genres,
      this.isFavorite = false});

  Novel.fromShallow(
      {required ShallowNovel shallowNovel,
      required this.authors,
      required this.description,
      required this.status,
      required this.chapters,
      required this.sourceName,
      this.alternateTitles,
      this.genres,
      this.isFavorite = false})
      : title = shallowNovel.title,
        coverUrl = shallowNovel.coverUrl,
        sourceUrl = shallowNovel.sourceUrl;

  @override
  String toString() {
    return "Novel(title: $title, authors: $authors, status: $status, description: ${description.substring(0, 50 > description.length ? description.length : 50)}, coverUrl: $coverUrl, sourceUrl: $sourceUrl, genres: $genres, chapters: ${chapters.length}, isFavorite: $isFavorite)";
  }

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnTitle: title,
      columnSourceUrl: sourceUrl,
      columnCoverUrl: coverUrl,
      columnDescription: description,
      columnStatus: status,
      columnAuthors: authors.join(","),
      columnAlternateTitles: alternateTitles?.join(","),
      columnGenres: genres?.join(","),
      columnChapters: chapters
          .where((e) => e.id != null && e.id! > 0)
          .map((e) => e.id)
          .join(','),
      columnSourceName: sourceName,
      columnIsFavorite: isFavorite == true ? 1 : 0,
    };
  }

  static Future<Novel> fromMap(Map<dynamic, dynamic> map) async {
    ChapterProvider chapterProvider = ChapterProvider();
    await chapterProvider.open(NKConfig.dbPath);

    return Novel(
        title: map[columnTitle],
        authors: map[columnAuthors].split(","),
        description: map[columnDescription],
        coverUrl: map[columnCoverUrl],
        sourceUrl: map[columnSourceUrl],
        status: map[columnStatus],
        sourceName: map[columnSourceName],
        alternateTitles: map[columnAlternateTitles]?.split(","),
        chapters: map[columnChapters]
                ?.split(",")
                ?.map((e) => chapterProvider.getChapter(int.parse(e)))
                ?.toList() ??
            [],
        genres: map[columnGenres]?.split(","),
        isFavorite: map[columnIsFavorite] == 1);
  }
}

class NovelProvider {
  late Database _db;

  /// Open the database
  Future open(String path) async {
    _db = await openDatabase(path, version: dbVersion,
        onCreate: (Database db, int version) async {
      await db.execute('''
          create table $tableName ( 
            $columnId integer primary key autoincrement, 
            $columnTitle text not null,
            $columnSourceUrl text not null,
            $columnCoverUrl text not null,
            $columnDescription text not null,
            $columnStatus text not null,
            $columnAuthors text not null,
            $columnAlternateTitles text,
            $columnChapters text,
            $columnGenres text,
            $columnSourceName text not null,
            $columnIsFavorite boolean not null)
          ''');
    });
  }

  Future<Novel> insert(Novel novel) async {
    novel.id = await _db.insert(tableName, novel.toMap());
    return novel;
  }

  /// Get a novel by id
  /// @param id the id of the novel
  /// Returns a novel
  /// If the novel is not found, returns a novel with empty fields
  Future<Novel> getNovel(int id) async {
    List<Map> maps = await _db.query(tableName,
        columns: [
          columnId,
          columnTitle,
          columnSourceUrl,
          columnCoverUrl,
          columnDescription,
          columnStatus,
          columnAuthors,
          columnAlternateTitles,
          columnChapters,
          columnGenres,
          columnSourceName,
          columnIsFavorite
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Novel.fromMap(maps.first);
    }
    return Novel(
        title: "",
        authors: [],
        description: "",
        coverUrl: "",
        sourceUrl: "",
        status: "",
        chapters: [],
        sourceName: "");
  }

  /// Get all novels
  /// Returns a list of novels
  /// If the list is empty, there are no novels
  /// The list is ordered by id in descending order
  Future<List<Novel>> getAllNovels() async {
    List<Map> maps = await _db.query(tableName,
        columns: [
          columnId,
          columnTitle,
          columnSourceUrl,
          columnCoverUrl,
          columnDescription,
          columnStatus,
          columnAuthors,
          columnAlternateTitles,
          columnChapters,
          columnGenres,
          columnSourceName,
          columnIsFavorite
        ],
        orderBy: "$columnId DESC");
    if (maps.isNotEmpty) {
      var maps2 = maps.map((e) async => await Novel.fromMap(e)).toList();
      List<Novel> maps3 = [];
      for (var map in maps2) {
        maps3.add(await map);
      }
      return maps3;
    }
    return [];
  }

  /// Get all favorite novels
  /// Returns a list of novels
  /// If the list is empty, there are no favorite novels
  Future<List<Novel>> getFavoriteNovels() async {
    List<Map> maps = await _db.query(tableName,
        columns: [
          columnId,
          columnTitle,
          columnSourceUrl,
          columnCoverUrl,
          columnDescription,
          columnStatus,
          columnAuthors,
          columnAlternateTitles,
          columnChapters,
          columnGenres,
          columnSourceName,
          columnIsFavorite
        ],
        where: "$columnIsFavorite = ?",
        whereArgs: [1],
        orderBy: "$columnId DESC");
    if (maps.isNotEmpty) {
      var maps2 = maps.map((e) async => await Novel.fromMap(e)).toList();
      List<Novel> maps3 = [];
      for (var map in maps2) {
        maps3.add(await map);
      }
      return maps3;
    }
    return [];
  }

  /// Delete a novel by id
  /// Returns the number of changes made
  /// If the number is 0, the novel was not found
  Future<int> delete(int id) async {
    return await _db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  /// Update a novel
  /// Returns the number of changes made
  /// If the number is 0, the novel was not found
  Future<int> update(Novel novel) async {
    return await _db.update(tableName, novel.toMap(),
        where: '$columnId = ?', whereArgs: [novel.id]);
  }

  /// Close the database
  Future close() async => _db.close();
}
