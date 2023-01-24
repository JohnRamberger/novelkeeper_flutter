import 'package:flutter/material.dart';
import 'package:novelkeeper_flutter/Model/novel/chapter.model.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:novelkeeper_flutter/Components/novel_details.component.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';
import 'package:novelkeeper_flutter/Source/novel_full.source.dart';
import 'package:novelkeeper_flutter/ViewModel/novel_details.viewmodel.dart';
import 'package:novelkeeper_flutter/utils/Url/url.dart';

import '../../Component/chapter_item.component.dart';
import '../../Model/novel/novel.model.dart';

import 'package:provider/provider.dart';

class NovelDetailsView extends StatefulWidget {
  const NovelDetailsView({required this.shallowNovel, super.key});

  final ShallowNovel shallowNovel;

  @override
  State<NovelDetailsView> createState() => _NovelDetailsViewState();
}

class _NovelDetailsViewState extends State<NovelDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ChangeNotifierProvider(
          create: (context) =>
              NovelDetailsViewModel(shallowNovel: widget.shallowNovel),
          child: _buildLoading(),
        ));
  }

  Widget _buildLoading() {
    return Consumer<NovelDetailsViewModel>(
      builder: (context, model, child) {
        if (model.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return _buildDetails();
        }
      },
    );
  }

  Widget _buildDetails() {
    return Consumer<NovelDetailsViewModel>(builder: (context, model, child) {
      return SingleChildScrollView(
          child: Column(children: [
        // TODO: fix NovelDetails from lagging
        // NovelDetails(novel: _novel),
        ListView.builder(
          itemCount: model.chaptersRev.length,
          prototypeItem: ChapterItem(chapter: model.chaptersRev[0]),
          itemBuilder: (context, index) {
            return ChapterItem(chapter: model.chaptersRev[index]);
          },
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
        )
      ]));
    });
  }
}
