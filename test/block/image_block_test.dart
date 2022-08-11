import 'package:draft_view/draft_view/blocks/image_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'blockquote_test.dart';

void main() {
  group("Test image block", () {
    late BuildContext context;
    Key key = Key("rich-text");

    setUp(() {
      context = MockBuildContext();
    });

    testWidgets("simple test", (tester) async {
      var block = ImageBlock(
        depth: 0,
        start: 0,
        end: 1,
        inlineStyles: [],
        data: {"description": "abc.com"},
        text: "",
        entityTypes: [],
        blockType: "image",
      );

      var component = MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => RichText(
              key: key,
              text: block.render(context),
            ),
          ),
        ),
      );

      await tester.pumpWidget(component);
      expect(find.text("abc.com"), findsOneWidget);

      final RenderBox box = tester.renderObject(find.byKey(key));
      await tester
          .tapAt(box.localToGlobal(Offset.zero) + const Offset(2.0, 2.0));

      await tester.pumpAndSettle();
      expect(find.text("abc.com"), findsWidgets);
    });

    testWidgets("Test detail image", (tester) async {
      var component = MaterialApp(
        home: Scaffold(
          body: ImageDetailView(
            url: '',
            caption: "abc.com",
          ),
        ),
      );

      await tester.pumpWidget(component);
      expect(find.text("abc.com"), findsOneWidget);
    });
  });
}
