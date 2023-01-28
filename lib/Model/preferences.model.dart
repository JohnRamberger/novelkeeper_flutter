import 'package:hive/hive.dart';

// part 'preferences.model.g.dart';

@HiveType(typeId: 2)
class Preferences extends HiveObject {
  @HiveField(0)
  bool isDarkMode = false;

  @HiveField(1)
  bool isDownloadedOnly = false;

  @HiveField(2)
  bool isIncognito = false;
}
