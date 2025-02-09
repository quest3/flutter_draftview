import 'package:flutter/material.dart';

import '../blocks/blocks.dart' show BaseBlock;
import '../converter/converter.dart' show Converter;
import '../plugins/plugins.dart' show BasePlugin;

class DraftView extends StatefulWidget {
  final Map<String, dynamic> rawDraftData;
  final List<BasePlugin> plugins;

  const DraftView({Key? key, required this.rawDraftData, required this.plugins})
      : super(key: key);

  @override
  _DraftViewState createState() => _DraftViewState();
}

class _DraftViewState extends State<DraftView> {
  List<BaseBlock> blocks = [];

  @override
  void initState() {
    super.initState();
    blocks = _convertToBlocks();
  }

  @override
  void didUpdateWidget(DraftView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.plugins != widget.plugins ||
        oldWidget.rawDraftData != widget.rawDraftData) {
      setState(() {
        blocks = _convertToBlocks();
      });
    }
  }

  List<BaseBlock> _convertToBlocks() {
    var converter =
        Converter(plugins: widget.plugins, draftData: widget.rawDraftData);
    return converter.convert();
  }

  List<InlineSpan> _renderText() {
    List<InlineSpan> spans = [];
    int i = 0;

    while (i < blocks.length) {
      var curBlock = blocks[i];

      var span = curBlock.render(
        context,
        children:
            curBlock.children?.map((e) => e.render(context)).toList() ?? [],
      );
      spans.add(span);

      i++;
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: _renderText()));
  }
}
