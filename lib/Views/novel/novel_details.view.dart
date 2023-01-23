import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:novelkeeper_flutter/Model/novel/shallow.novel.model.dart';

class NovelDetailsView extends StatefulWidget {
  const NovelDetailsView({required this.shallowNovel, super.key});

  final ShallowNovel shallowNovel;

  @override
  State<NovelDetailsView> createState() => _NovelDetailsViewState();
}

class _NovelDetailsViewState extends State<NovelDetailsView> {
  bool _loadingDetails = true;

  @override
  Widget build(BuildContext context) {
    if (_loadingDetails) {
      _loadDetails();
    }

    return Scaffold(appBar: AppBar(), body: _buildLoading());
  }

  _loadDetails() async {
    setState(() {
      _loadingDetails = false;
    });
    // TODO: load details from site
  }

  Widget _buildLoading() {
    return _loadingDetails
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _buildDetails();
  }

  Widget _buildDetails() {
    return Container(child: Text("details"));
  }
}
