import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:novelkeeper_flutter/utils/Scraping/scrape.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  bool _scraping = true;
  @override
  Widget build(BuildContext context) {
    if (_scraping) {
      Scrape(
          url: "novelfullhjkhj.com",
          onError: (err) {
            
          },
          onSuccess: (doc) {
            print(doc);
          });
    }
    return Container();
  }
}
