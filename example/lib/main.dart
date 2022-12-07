import 'package:draft_renderer/draft_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';

import 'draft_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DraftWidget Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          headline4: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          headline5: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(height: 1.5, fontSize: 14),
        ),
      ),
      home: const Demo(),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("DraftWidget"),
      ),
      child: Scaffold(
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 108,
                bottom: 48,
                left: 16,
                right: 16,
              ),
              child: Material(
                child: DraftWidget(
                  rawDraftData: data,
                  codeStyle: const TextStyle(fontSize: 13, fontFamily: 'mono', fontWeight: FontWeight.w400, color: Colors.black),
                  linkColor: Colors.blue,
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
    );
  }
}
