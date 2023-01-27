import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:isolate';
import 'package:novelkeeper_flutter/Component/main_navigation.dart';
import "package:novelkeeper_flutter/Config/config.dart";
// import 'package:novelkeeper_flutter/Views/library.view.dart';

// import 'package:novelkeeper_flutter/utils/Update/auto_update.dart';
import 'package:novelkeeper_flutter/utils/Updater/updater.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ReceivePort _port = ReceivePort();

  dynamic _releaseInfo = {};

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);

    initPlatformState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
    if (status.value == 3) {
      // completed

    }
  }

  Future<void> initPlatformState() async {
    var updater = await Updater.checkGithubForRelease();
    setState(() {
      _releaseInfo = updater;
    });
    if (updater["update"]) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // show update dialog
        await showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                title: Text("Update Available"),
                content: Text(
                    "A new version of ${NKConfig.appName} is available. Would you like to update?"),
                actions: [
                  TextButton(
                    child: Text("Later"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text("Update"),
                    onPressed: () async {
                      await Updater.downloadRelease(updater["assetUrl"],
                          updater["version"], updater["name"]);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }));
      });

      // await Updater.downloadRelease(
      //     updater["assetUrl"], updater["version"], updater["name"]);
    }
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
    return const MainNavigation();
  }
}
