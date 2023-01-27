import "package:flutter/material.dart";
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:novelkeeper_flutter/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  runApp(const MyApp());
}
