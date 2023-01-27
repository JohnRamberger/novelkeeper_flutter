import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:http/http.dart";
import 'package:package_info_plus/package_info_plus.dart';
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
              "version": map['tag_name']
            };
          }
        }
      } else {
        return {"update": false};
      }
    }

    return {"update": false};
  }

  static Future<void> downloadAndUpdate(String url) async {
    

  }
}

int getExtendedVersionNumber(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
}
