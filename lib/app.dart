import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novelkeeper_flutter/Component/main_navigation.dart';
import "package:novelkeeper_flutter/Config/config.dart";
// import 'package:novelkeeper_flutter/Views/library.view.dart';

// import 'package:novelkeeper_flutter/utils/Update/auto_update.dart';
import 'package:auto_update/auto_update.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<dynamic, dynamic> _packageUpdateUrl = {};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    
  }

  // Future<void> updateApp() async {
  //   if (_packageUpdateUrl['assetUrl'].isNotEmpty &&
  //       _packageUpdateUrl['assetUrl'] != "up-to-date" &&
  //       (_packageUpdateUrl['assetUrl'] as String).contains("https://")) {
  //     try {
  //       await AutoUpdate.downloadAndUpdate(_packageUpdateUrl['assetUrl']);
  //     } on PlatformException {
  //       setState(() {
  //         _packageUpdateUrl['assetUrl'] = "Unable to download";
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: return to last opened page
    return MaterialApp(
      title: NKConfig.appName,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MainNavigation(),
    );
  }
}
