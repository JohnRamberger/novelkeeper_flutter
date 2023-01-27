import 'package:novelkeeper_flutter/Model/scrape_client.model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NKConfig {
  static const String appName = "Novel Keeper";
  static var scrapeClient = ScrapeClient();
  static const String dbPath = "novelkeeper.db";

  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), dbPath),
      onCreate: (db, version) {
        // initialize the db on first creation
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> init() async {
    // open the db
  }
}
