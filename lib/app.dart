import 'package:flutter/material.dart';
import "package:novelkeeper_flutter/Config/config.dart";
import 'package:novelkeeper_flutter/Views/library.view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // TODO: return to last opened page

    return MaterialApp(
      title: NKConfig.appName,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const LibraryView(),
    );
  }
}
