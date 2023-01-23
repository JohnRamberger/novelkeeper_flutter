import 'package:flutter/material.dart';
import 'package:novelkeeper_flutter/Components/shallow_novel_card.component.dart';
import 'package:novelkeeper_flutter/Config/config.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';
import 'package:novelkeeper_flutter/Sources/novel_full.source.dart';

class NovelfullView extends StatefulWidget {
  const NovelfullView({super.key});

  @override
  State<NovelfullView> createState() => _NovelfullViewState();
}

class _NovelfullViewState extends State<NovelfullView> {
  List<ShallowNovel> _novels = [];
  int _currPage = 1;
  int _pages = 1;
  bool _loading = true;
  @override
  Widget build(BuildContext context) {
    if (_loading) {
      _loadSearch("the");
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Novelfull"),
        ),
        body: _buildBody());
  }

  _loadSearch(String query) async {
    setState(() {
      _loading = true;
    });
    var result = await NovelFull().searchNovelJob(query: query);
    setState(() {
      _novels = result.novels;
      _pages = result.pageCount;
      _loading = false;
    });
  }

  Widget _buildBody() {
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : _buildNovelList();
  }

  Widget _buildNovelList() {
    return SingleChildScrollView(
        child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.6,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: _novels.length,
      itemBuilder: (context, index) {
        return _buildNovel(_novels[index]);
      },
    ));
  }

  Widget _buildNovel(ShallowNovel novel) {
    return ShallowNovelCard(novel: novel);
  }
}
