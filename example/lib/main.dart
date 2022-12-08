import 'package:draft_view/draft_view.dart';
import 'package:draft_view/theme.dart';
import 'package:example/draft_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'DraftView Demo',
      home: Demo(),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("DraftView"),
      ),
      child: Scaffold(
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 48,
                left: 16,
                right: 16,
              ),
              child: SafeArea(
                child: Material(
                  child: DraftView(
                    rawDraftData: data,
                    draftViewTheme: const DraftViewTheme(
                      textStyle: TextStyle(fontSize: 14, color: Colors.black, height: 1.5),
                      boldStyle: TextStyle(fontSize: 14, color: Colors.black, height: 1.5, fontWeight: FontWeight.bold),
                      italicStyle: TextStyle(fontSize: 14, color: Colors.black, height: 1.5, fontStyle: FontStyle.italic),
                      highlightedStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                      orderedListItemStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        height: 1.5,
                      ),
                      unorderedListItemStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        height: 1.5,
                      ),
                      h1Style: TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
                      h2Style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                      h3Style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                      h4Style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                      h5Style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                      h6Style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                      codeStyle: TextStyle(fontSize: 13, fontFamily: 'mono', fontWeight: FontWeight.w300, color: Colors.black),
                      blockquoteStyle: TextStyle(fontSize: 14, color: Colors.black, fontStyle: FontStyle.italic),
                      linkColor: Colors.green,
                    ),
                    context: context,
                    onTapImage: (url) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          insetPadding: const EdgeInsets.all(16),
                          content: Image.network(url),
                        ),
                      );
                    },
                    onTapLink: (data) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text(
                            prettyJson(data),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      );
                    },
                    customImageWidget: (url) => ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.network(
                        url,
                        fit: BoxFit.fitWidth,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 200,
                            color: Colors.grey.withOpacity(0.4),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
