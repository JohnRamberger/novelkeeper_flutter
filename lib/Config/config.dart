import 'package:novelkeeper_flutter/Model/scrape_client.model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NKConfig {
  static const String appName = "Novel Keeper";
  static var scrapeClient = ScrapeClient();
  static const String dbPath = "novelkeeper.db";

  static Future<void> init() async {
    // init stuff
  }
}
