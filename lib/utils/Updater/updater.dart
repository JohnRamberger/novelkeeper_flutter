import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import "package:http/http.dart";
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:version/version.dart';

class Updater {
  static Client _client = Client();

  static Future<dynamic> checkGithubForRelease() async {
    String url =
        "https://api.github.com/repos/JohnRamberger/novelkeeper_flutter/releases/latest";
    Uri uri = Uri.parse(url);
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      // success -- read the response body
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final Map<dynamic, dynamic> map = json.decode(response.body);
      Version githubVersion =
          Version.parse(map['tag_name'].toString().replaceFirst("v", ""));
      Version currentVersion = Version.parse(packageInfo.version);

      if (githubVersion > currentVersion) {
        // print("New version available: ${map['tag_name']}");
        // get assets
        var assets = map['assets'];
        for (var asset in assets) {
          if (asset["name"].contains("apk")) {
            // print("Found apk: ${asset['browser_download_url']}");
            return {
              "update": true,
              "assetUrl": asset['browser_download_url'],
              "version": map['tag_name'],
              "name": asset['name']
            };
          }
        }
      } else {
        return {"update": false};
      }
    }

    return {"update": false};
  }

  static Future<void> downloadRelease(
      String url, String version, String name) async {
    Directory? tempDir = await getApplicationDocumentsDirectory();
    // create a new folder in temp dir
    final nk = await getExternalStorageDirectory();
    // final Directory nk = Directory('${tempDir.path}/novelkeeper/$version')
    //   ..createSync(recursive: true);

    final taskId = await FlutterDownloader.enqueue(
        url: url,
        headers: {}, // optional: header send with url (auth token etc)
        savedDir: nk!.path,
        showNotification:
            false, // show download progress in status bar (for Android)
        openFileFromNotification:
            false, // click on notification to open downloaded file (for Android)
        saveInPublicStorage: true);
  }

  // static Future<void> installRelease(String taskId) async {
  //   print("ready to install");
  //   // final tasks = await FlutterDownloader.loadTasksWithRawQuery(
  //   //     query: 'SELECT * FROM task WHERE status=3');

  //   // if (tasks == null || tasks.isEmpty) {
  //   //   return;
  //   // }

  //   // final task = tasks.first;
  //   // final apkPath = "${task.savedDir}/${task.filename ?? ""}";
  //   await FlutterDownloader.open(taskId: taskId);

  //   return;
  // }
}

int getExtendedVersionNumber(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
}
