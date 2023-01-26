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
    Map<dynamic, dynamic> updateUrl;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      updateUrl = await AutoUpdate.fetchGithub(
        "johnramberger",
        "novelkeeper_flutter",
      );
    } on PlatformException {
      updateUrl = {'assetUrl': 'Failed to get the url of the new release.'};
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _packageUpdateUrl = updateUrl;
    });
  }

  Future<void> updateApp() async {
    if (_packageUpdateUrl['assetUrl'].isNotEmpty &&
        _packageUpdateUrl['assetUrl'] != "up-to-date" &&
        (_packageUpdateUrl['assetUrl'] as String).contains("https://")) {
      try {
        await AutoUpdate.downloadAndUpdate(_packageUpdateUrl['assetUrl']);
      } on PlatformException {
        setState(() {
          _packageUpdateUrl['assetUrl'] = "Unable to download";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: return to last opened page

    print(_packageUpdateUrl);

    return MaterialApp(
      title: NKConfig.appName,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MainNavigation(),
    );
  }
}
