import 'package:novelkeeper_flutter/Model/scrape_client.model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/sqflite_migration.dart';

import 'package:novelkeeper_flutter/utils/Sqlite/schema.dart';
import 'package:novelkeeper_flutter/utils/Sqlite/migrations.dart';

final config = MigrationConfig(
    initializationScript: initialScript, migrationScripts: migrations);

class NKConfig {
  static const String appName = "Novel Keeper";
  static var scrapeClient = ScrapeClient();
  static String dbPath = "";

  static Future<Database> openDB() async {
    return await openDatabaseWithMigration(dbPath, config);
  }

  static Future<void> init() async {
    // init stuff
    dbPath = join(await getDatabasesPath(), "novelkeeper.db");

    // open the database
  }
}
