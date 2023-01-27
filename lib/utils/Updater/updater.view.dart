import 'dart:ui';

import 'package:app_installer/app_installer.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:novelkeeper_flutter/utils/Updater/updater.dart';

import '../../Config/config.dart';

class UpdateChecker extends StatefulWidget {
  const UpdateChecker({required this.startView, super.key});

  final Widget startView;

  @override
  State<UpdateChecker> createState() => _UpdateCheckerState();
}

class _UpdateCheckerState extends State<UpdateChecker> {
  final ReceivePort _port = ReceivePort();

  dynamic _releaseInfo = {};

  @override
  void initState() {
    super.initState();

    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

    initPlatformState();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) async {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
    // if (status.value == 3) {
    //   // completed
    //   var tasks = await FlutterDownloader.loadTasks();
    //   if (tasks == null || tasks.isEmpty) return;
    //   for (var task in tasks) {
    //     if (task.taskId == id) {
    //       AppInstaller.installApk(
    //           "${task.savedDir}/${task.filename ?? "app-release.apk"}");
    //     }
    //   }
    // }
  }

  void _bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      final taskId = (data as List<dynamic>)[0] as String;
      final status = data[1] as DownloadTaskStatus;
      final progress = data[2] as int;

      print(
        'Callback on UI isolate: '
        'task ($taskId) is in status ($status) and process ($progress)',
      );

      if (status.value == 3) {
        // completed
        Updater.installRelease(taskId);
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
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
                title: const Text("Update Available"),
                content: const Text(
                    "A new version of ${NKConfig.appName} is available. Would you like to update?"),
                actions: [
                  TextButton(
                    child: const Text("Later"),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  TextButton(
                    child: const Text("Update"),
                    onPressed: () async {
                      await Updater.downloadRelease(updater["assetUrl"],
                          updater["version"], updater["name"]);
                      Navigator.of(context, rootNavigator: true).pop();
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
    return widget.startView;
  }
}
