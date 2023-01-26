import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:novelkeeper_flutter/ViewModel/text_closed.viewmodel.dart';
import 'package:provider/provider.dart';

class TextClosed extends StatelessWidget {
  const TextClosed(
      {required this.text, this.labelText = "", this.maxLines = 5, super.key});

  final String text;
  final String labelText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TextClosedViewModel>(
        create: (context) => TextClosedViewModel(),
        child: Consumer<TextClosedViewModel>(builder: ((context, value, child) {
          return InkWell(
            borderRadius: BorderRadius.circular(8),
            child: Container(
                padding: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: RichText(
                          text: TextSpan(children: [
                            labelText.isNotEmpty
                                ? TextSpan(
                                    text: "$labelText ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold))
                                : const TextSpan(),
                            TextSpan(text: text)
                          ]),
                          maxLines: value.isClosed ? maxLines : null,
                          overflow: TextOverflow.fade,
                        )),
                    Positioned.fill(
                        bottom: -10,
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            // TODO: add rotated animation to arrow icon
                            child: Icon(
                              value.isClosed
                                  ? Icons.expand_more
                                  : Icons.expand_less,
                              size: 34,
                            )))
                  ],
                )),
            onTap: () {
              value.toggle();
            },
            onLongPress: () {
              // Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Press to expand/collapse"),
              ));
            },
          );
        })));
  }
}
