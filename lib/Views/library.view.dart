import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:novelkeeper_flutter/Sources/novel_full.source.dart';
import 'package:novelkeeper_flutter/utils/Scraping/scrape.dart';
import 'package:novelkeeper_flutter/Model/scrape_job.model.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  bool _loading = true;
  @override
  Widget build(BuildContext context) {
    if (_loading) {
      _search();
    }
    return Container();
  }

  _search() async {
    var x = await NovelFull().searchNovelJob(query: "a");
    print(x);
  }
}
