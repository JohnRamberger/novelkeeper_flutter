import 'package:novelkeeper_flutter/Model/scrape_client.model.dart';


// final config = MigrationConfig(
//     initializationScript: initialScript, migrationScripts: migrations);

class NKConfig {
  static const String appName = "Novel Keeper";
  static var scrapeClient = ScrapeClient();

  static String boxNovelCache = "novel_cache";

  static Future<void> init() async {
    // init stuff
  }
}
