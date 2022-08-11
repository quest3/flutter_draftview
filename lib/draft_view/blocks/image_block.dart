import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'action_block.dart';
import 'base_block.dart';
import 'callbacks.dart';

class ImageBlock extends ActionBlock {
  ImageBlock({
    required int depth,
    required int start,
    required int end,
    required List<String> inlineStyles,
    required Map<String, dynamic> data,
    required String text,
    required List<String> entityTypes,
    required String blockType,
    ActionBuilder? actionBuilder,
    OnTap? onTap,
    OnDoubleTap? onDoubleTap,
    OnLongPress? onLongPress,
    List<BaseBlock>? children,
  }) : super(
          depth: depth,
          start: start,
          end: end,
          inlineStyles: inlineStyles,
          data: data,
          text: text,
          entityTypes: entityTypes,
          blockType: blockType,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          actionBuilder: actionBuilder,
          children: children,
        );

  ImageBlock copyWith({BaseBlock? block}) => ImageBlock(
        depth: block?.depth ?? this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        actionBuilder: actionBuilder,
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
      );

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    var actions = actionBuilder != null ? actionBuilder!(this) : null;

    return WidgetSpan(
      child: ImageComponent(
        url: data['src'],
        caption: data['description'],
        onDoubleTap: onDoubleTap,
        onTap: onTap,
        onLongPress: onLongPress,
        actions: actions,
        imageBlock: this,
      ),
    );
  }
}

class ImageComponent extends StatefulWidget {
  final String url;
  final String caption;
  final OnLongPress? onLongPress;
  final OnTap? onTap;
  final OnDoubleTap? onDoubleTap;
  final List<CupertinoContextMenuAction>? actions;
  final ImageBlock imageBlock;

  ImageComponent({
    required this.url,
    required this.caption,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.actions,
    required this.imageBlock,
  });

  @override
  _ImageComponentState createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.url.isNotEmpty
            ? Center(
                child: _buildImage(),
              )
            : SizedBox.shrink(),
        Hero(tag: Key(widget.caption), child: Text(widget.caption)),
      ],
    );
  }

  Widget _buildImage() {
    var image = GestureDetector(
      onDoubleTap: () => {
        if (widget.onDoubleTap != null) widget.onDoubleTap!(widget.imageBlock)
      },
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(widget.imageBlock);
        } else {
          if (widget.actions == null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) =>
                    ImageDetailView(url: widget.url, caption: widget.caption),
              ),
            );
          }
        }
      },
      child: Hero(
        tag: widget.url,
        child: Image.network(
          widget.url,
          fit: BoxFit.fitWidth,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 200,
              color: Colors.grey.withOpacity(0.4),
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          },
        ),
      ),
    );
    if (widget.actions == null) {
      return image;
    } else {
      return CupertinoContextMenu(
        child: image,
        actions: widget.actions!,
      );
    }
  }
}

class ImageDetailView extends StatefulWidget {
  final String url;
  final String caption;

  const ImageDetailView({
    Key? key,
    required this.url,
    required this.caption,
  }) : super(key: key);

  @override
  _ImageDetailViewState createState() => _ImageDetailViewState();
}

class _ImageDetailViewState extends State<ImageDetailView> {
  final TransformationController _transformationController =
      TransformationController();
  bool zoomed = false;

  late TapDownDetails _doubleTapDetails;

  @override
  void initState() {
    super.initState();
    _transformationController.addListener(() {
      setState(() {
        zoomed = _transformationController.value != Matrix4.identity();
      });
    });
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: Stack(
        children: [
          if (widget.url.isNotEmpty)
            GestureDetector(
              onDoubleTapDown: _handleDoubleTapDown,
              onDoubleTap: _handleDoubleTap,
              child: Center(
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  panEnabled: zoomed,
                  boundaryMargin: EdgeInsets.all(30),
                  minScale: 0.5,
                  maxScale: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Hero(
                      tag: widget.url,
                      child: Image.network(
                        widget.url,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Hero(
                  tag: widget.caption,
                  child: Text(
                    widget.caption,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
