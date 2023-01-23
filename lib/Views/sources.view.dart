import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:novelkeeper_flutter/Views/Sources/novel_full.view.dart';

class SourcesView extends StatefulWidget {
  const SourcesView({super.key});

  @override
  State<SourcesView> createState() => _SourcesViewState();
}

class _SourcesViewState extends State<SourcesView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text("Novelfull"),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NovelfullView()));
          },
        )
      ],
    );
  }
}
