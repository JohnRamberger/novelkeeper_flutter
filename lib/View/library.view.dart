// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:novelkeeper_flutter/Sources/novel_full.source.dart';
// import 'package:novelkeeper_flutter/utils/Scraping/scrape.dart';
// import 'package:novelkeeper_flutter/Model/scrape_job.model.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  PackageInfo packageInfo = PackageInfo(
    appName: "NovelKeeper",
    packageName: "com.novelkeeper.novelkeeper",
    version: "-1:-1:-1",
    buildNumber: "0",
  );

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        this.packageInfo = packageInfo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(packageInfo.version));
  }
}
