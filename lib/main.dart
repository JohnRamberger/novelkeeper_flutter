import "package:flutter/material.dart";
import 'package:novelkeeper_flutter/app.dart';

import 'package:auto_update/auto_update.dart';

void main() async {
  // check app version
  Map<dynamic, dynamic> results =
      await AutoUpdate.fetchGithub("JohnRamberger", "novelkeeper_flutter");
  if (results != null) {
    if (results['assetUrl'] == "up-to-date") {
      /* aplication is up-to-date */
      print("up-to-date");
    } else if (results['assetUrl'].isEmpty()) {
      /* package or user don't found */
      print("package or user don't found");
    } else {
      /* update url found */
      print("update url found");
    }
  }

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
