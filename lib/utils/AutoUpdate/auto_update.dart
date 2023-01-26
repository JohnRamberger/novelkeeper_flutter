import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
// import './desktop.dart';
import './fetch_github.dart' as gb;
// import 'desktop.dart';

class AutoUpdate {
  // static const MethodChannel _channel = MethodChannel('auto_update');

  // static Future<String> getDocumentsFolder() async {
  //   if (Platform.isWindows) {
  //     return (await _channel.invokeMethod("getDocumentsFolder")).toString();
  //   }
  //   return "";
  // }

  static Future<Map<dynamic, dynamic>> fetchGithub(
      String user, String packageName,
      {String fileType = ".exe"}) async {
    Map<dynamic, dynamic> res = {};
    if (Platform.isAndroid) {
      return await fetchGithub(user, packageName);
    }
    return res;
  }

  static Future<void> downloadAndUpdate(String url) async {
    if (Platform.isAndroid) {
      // await _channel.invokeMethod("downloadAndUpdate", {"url": url});
    }
    // else if (Platform.isWindows) {
    //   String? filePath = await downloadFile(
    //       Uri.parse(url),
    //       (await _channel.invokeMethod("getDownloadFolder")).toString() + "\\",
    //       url.split("/").last);
    //   if (filePath != null) {
    //     if ((await _channel
    //             .invokeMethod("runFileWindows", {"filePath": filePath})) >
    //         32) {
    //       exit(0);
    //     }
    //   }
    // }
  }
}

Future<Map<String, String>> fetchGithub(String user, String packageName,
    String type, String version, String appName) async {
  Map<String, String> results = {"assetUrl": ""};
  final client = HttpClient();
  client.userAgent = "auto_update";

  final request = await client.getUrl(Uri.parse(
      "https://api.github.com/repos/$user/$packageName/releases/latest"));
  final response = await request.close();
  print(response);
  if (response.statusCode == 200) {
    final contentAsString = await utf8.decodeStream(response);
    final Map<dynamic, dynamic> map = json.decode(contentAsString);
    print(map);
    if (map["tag_name"] != null &&
        map["tag_name"] != version &&
        map["assets"] != null) {
      for (Map<dynamic, dynamic> asset in map["assets"]) {
        // print("x");
        if ((asset["content_type"] != null && asset["content_type"] == type) &&
            (asset["name"] != null && asset["name"] == appName)) {
          print(asset);
          results["assetUrl"] = asset["browser_download_url"] ?? '';
          results["body"] = map["body"] ?? '';
          results["tag"] = map["tag_name"] ?? '';
        }
      }
    }
  }

  return results;
}
