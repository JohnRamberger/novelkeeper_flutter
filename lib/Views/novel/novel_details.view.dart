import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:novelkeeper_flutter/Components/novel_details.component.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';
import 'package:novelkeeper_flutter/Sources/novel_full.source.dart';
import 'package:novelkeeper_flutter/utils/Url/url.dart';

import '../../Components/chapter_item.component.dart';
import '../../Model/novel/novel.model.dart';

class NovelDetailsView extends StatefulWidget {
  const NovelDetailsView({required this.shallowNovel, super.key});

  final ShallowNovel shallowNovel;

  @override
  State<NovelDetailsView> createState() => _NovelDetailsViewState();
}

class _NovelDetailsViewState extends State<NovelDetailsView> {
  bool _loadingDetails = true;
  late Novel _novel;

  @override
  Widget build(BuildContext context) {
    if (_loadingDetails) {
      _loadDetails();
    }

    return Scaffold(appBar: AppBar(), body: _buildLoading());
  }

  _loadDetails() async {
    setState(() {
      _loadingDetails = true;
    });
    // switch (baseUrl(widget.shallowNovel.sourceUrl)) {
    //  each case should be a source class
    switch (getBaseUrl(widget.shallowNovel.sourceUrl)) {
      case "https://novelfull.com":
        var novel = await NovelFull().getNovelDetailsJob(widget.shallowNovel);
        if (mounted) {
          setState(() {
            _novel = novel;
            _loadingDetails = false;
          });
        }
        break;
      default:
        throw Exception("Unknown source");
    }
  }

  Widget _buildLoading() {
    return _loadingDetails
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _buildDetails();
  }

  Widget _buildDetails() {
    return SingleChildScrollView(
      child: Column(children: [
        // TODO: fix NovelDetails from lagging
        // NovelDetails(novel: _novel),
        ListView.builder(
          itemCount: _novel.chapters.length,
          prototypeItem: ChapterItem(chapter: _novel.chapters[0]),
          itemBuilder: (context, index) {
            return ChapterItem(chapter: _novel.chapters[index]);
          },
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
        )
      ]),
    );
  }
}
