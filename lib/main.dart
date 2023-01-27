import "package:flutter/material.dart";
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:novelkeeper_flutter/app.dart';

import 'Config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false, ignoreSsl: true);
  runApp(MaterialApp(
      title: NKConfig.appName,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyApp()));
}
