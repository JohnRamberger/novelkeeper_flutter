import 'package:novelkeeper_flutter/Model/novel/chapter.model.dart';
import 'package:novelkeeper_flutter/Model/novel/novel.model.dart';

import 'Config/config.dart';

import "package:flutter/material.dart";
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:novelkeeper_flutter/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false, ignoreSsl: true);

  // init stuff
  // await NKConfig.init();

  // init Hive
  await Hive.initFlutter();
  // init hive adapters
  Hive.registerAdapter(NovelAdapter());
  Hive.registerAdapter(ChapterAdapter());

  runApp(MaterialApp(
      title: NKConfig.appName,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MyApp()));
}
