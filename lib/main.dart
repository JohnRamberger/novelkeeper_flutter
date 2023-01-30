import 'package:adaptive_theme/adaptive_theme.dart';
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

  // open hive boxes
  await Hive.openBox<Novel>(NKConfig.boxNovelCache);

  runApp(AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        accentColor: Colors.purple,
      ),
      dark: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color.fromRGBO(20, 31, 24, 1),
          backgroundColor: const Color.fromRGBO(20, 31, 24, 1),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromRGBO(20, 31, 24, 1),
              shadowColor: Colors.transparent),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color.fromRGBO(20, 31, 24, 1)),
          primarySwatch: Colors.purple,
          accentColor: Colors.purple),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
          title: NKConfig.appName,
          theme: theme,
          darkTheme: darkTheme,
          // primary: Color.fromRGBO(124, 96, 128, 1),
          // secondary: Color.fromRGBO(162, 136, 166, 1),
          // background: Color.fromRGBO(28, 29, 33, 1))),
          home: const MyApp())));
}
