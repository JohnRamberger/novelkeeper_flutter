// import 'dart:ui';

// import 'package:app_installer/app_installer.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'dart:isolate';
import 'package:novelkeeper_flutter/Component/main_navigation.dart';
// import "package:novelkeeper_flutter/Config/config.dart";
// // import 'package:novelkeeper_flutter/Views/library.view.dart';

// // import 'package:novelkeeper_flutter/utils/Update/auto_update.dart';
// import 'package:novelkeeper_flutter/utils/Updater/updater.dart';
import 'package:novelkeeper_flutter/utils/Updater/updater.view.dart';

class MyApp extends StatelessWidget {
  const MyApp({this.checkForUpdate = true, super.key});

  final bool checkForUpdate;

  @override
  Widget build(BuildContext context) {
    return UpdateChecker(
      startView: const MainNavigation(),
      checkForUpdate: checkForUpdate,
    );
  }
}
