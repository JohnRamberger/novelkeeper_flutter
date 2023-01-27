import 'package:novelkeeper_flutter/Model/scrape_client.model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NKConfig {
  static const String appName = "Novel Keeper";
  static var scrapeClient = ScrapeClient();
  static String dbPath = "";

  static Future<Database> openDB() async {
    return await openDatabase(dbPath);
  }

  static Future<void> init() async {
    // init stuff
    dbPath = join(await getDatabasesPath(), "novelkeeper1.db");

    // open the database
  }
}
