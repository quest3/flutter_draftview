import 'package:draft_view/draft_view.dart';
import 'package:draft_view/draft_view/block/draft_object.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_data.dart';

void main() {
  group("Test converter split block function", () {
    late BaseBlock baseBlock;
    late Map<String, RawDraftEntityKeyStringAny> entityMap;

    setUp(() {
      var text = "Hello World";
      baseBlock = BaseBlock(
        depth: 0,
        start: 0,
        end: text.length,
        inlineStyles: [],
        data: {},
        text: text,
        entityTypes: [],
        blockType: "unstyled",
      );

      entityMap = {
        "0": RawDraftEntityKeyStringAny(
          data: {"url": "bing.com"},
          mutability: "MUTABLE",
          type: "Link",
        ),
        "1": RawDraftEntityKeyStringAny(
          data: {"url": "abs.com"},
          mutability: "MUTABLE",
          type: "Link",
        )
      };
    });

    test("Split 1", () {
      List<RawDraftEntityRange> entityRanges = [
        RawDraftEntityRange(key: "0", length: 5, offset: 0),
        RawDraftEntityRange(key: "1", length: 6, offset: 5)
      ];

      var converter = Converter(plugins: [], draftData: testData);
      var blocks = converter.splitBlock(
          block: baseBlock,
          entities: entityRanges,
          inlines: [],
          entityMap: entityMap);
      expect(blocks.length, 2);
      expect(blocks[0].entityTypes, ['Link']);
      expect(blocks[1].entityTypes, ['Link']);
    });

    test("Split 2", () {
      List<RawDraftInlineStyleRange> inlines = [
        RawDraftInlineStyleRange(length: 5, offset: 0, style: "BOLD"),
        RawDraftInlineStyleRange(length: 6, offset: 5, style: "ITALIC"),
      ];
      var converter = Converter(plugins: [], draftData: testData);
      var blocks = converter.splitBlock(
        block: baseBlock,
        entities: [],
        inlines: inlines,
        entityMap: entityMap,
      );
      expect(blocks.length, 2);
      expect(blocks[0].entityTypes, []);
      expect(blocks[1].entityTypes, []);
      expect(blocks[0].inlineStyles, ['BOLD']);
      expect(blocks[1].inlineStyles, ['ITALIC']);
    });

    test("Split 3", () {
      List<RawDraftEntityRange> entityRanges = [
        RawDraftEntityRange(key: "0", length: 5, offset: 0),
        RawDraftEntityRange(key: "1", length: 6, offset: 5)
      ];
      List<RawDraftInlineStyleRange> inlines = [
        RawDraftInlineStyleRange(length: 5, offset: 0, style: "BOLD"),
        RawDraftInlineStyleRange(length: 6, offset: 5, style: "ITALIC"),
      ];
      var converter = Converter(plugins: [], draftData: testData);
      var blocks = converter.splitBlock(
        block: baseBlock,
        entities: entityRanges,
        inlines: inlines,
        entityMap: entityMap,
      );
      expect(blocks.length, 2);
      expect(blocks[0].entityTypes, ['Link']);
      expect(blocks[1].entityTypes, ['Link']);
      expect(blocks[0].inlineStyles, ['BOLD']);
      expect(blocks[1].inlineStyles, ['ITALIC']);
    });

    test("Split 4", () {
      List<RawDraftEntityRange> entityRanges = [
        RawDraftEntityRange(key: "0", length: 5, offset: 0),
        RawDraftEntityRange(key: "1", length: 6, offset: 5)
      ];
      List<RawDraftInlineStyleRange> inlines = [
        RawDraftInlineStyleRange(length: 3, offset: 2, style: "BOLD"),
        RawDraftInlineStyleRange(length: 6, offset: 5, style: "ITALIC"),
      ];
      var converter = Converter(plugins: [], draftData: testData);
      var blocks = converter.splitBlock(
        block: baseBlock,
        entities: entityRanges,
        inlines: inlines,
        entityMap: entityMap,
      );
      expect(blocks.length, 3);
    });
  });

  group("Test converter convert function", () {
    test("convert 1", () {
      var converter = Converter(plugins: [TextPlugin()], draftData: testData);
      var blocks = converter.convert();

      expect(blocks.length > 2, true);
    });

    test("convert 2", () {
      var data = {
        "blocks": [
          {
            "key": "7rk7h",
            "text":
                "了一个火堆过去，把莉莱辛辛苦苦做的雪人弄融化了。莉莱哭了，从家跑出去，边哭边摘手套，唱”let it go，let it go， can hold it back anymore”。正是这一段凄惨的故事，正是莉莱这悲惨的人生的转折点。她离开了那个家，离开了自己心爱的剑客，离开了这个悲伤的小镇。这是在她十岁的那一年，而这一天也恰巧是她的生日。",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [
              {"offset": 43, "length": 47, "style": "BOLD"}
            ],
            "entityRanges": [],
            "data": {}
          },
        ],
        "entityMap": {}
      };

      var converter = Converter(plugins: [TextPlugin()], draftData: data);
      var blocks = converter.convert();
      expect(blocks.length, 3);
    });

    test("Test convert with newline", () {
      var data = {
        "blocks": [
          {
            "key": "755mk",
            "text":
                "莉莱心想，这个貌似是叫2ao的游戏，好像是一个设定在名叫天辉夜宴的魔法世界。斯文应该很喜欢。结果就在这个时候，电视上又传来一个新闻：“刚刚发售的2ao游戏，因为制作人茅场晶彦的关系，多达20000名玩家被困在游戏中无法登出。”莉莱看到了电视上一闪而过的斯文的名字，哭了出来。立马跑回自己的小镇（十年未回的），见到了斯文。只见斯文虚弱的躺在床上，脸色十分不好。因为斯文家里不是很有钱，没办法给他最新型的阴养供给机，所以他已经长时间没怎么好好吃饭了。一想到这样，莉莱泣不成声，跑到了街上。就在这个时候，遇到在那里的凤凰院凶真（我）。凤凰院说：你怎么了，为啥哭了？”莉莱说，从小我就因为体型被同学欺负，被家长嫌弃，被姐姐玩弄。现在连我唯一的依靠——斯文，也可能",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "f1o2m",
            "text": "",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "aljgi",
            "text":
                "要离我而去了，为什么，为什么，为什么！！老天要这么玩弄我！凤凰院说：别哭啊，小妹妹，现在还有一个解决方法，你要不要听？ 什么方法！快说！莉莱急破脸，呐喊到。凤凰院胸针（我）扔出了个海报，上面写的叫厌食症互助小组。你去那看看，一定能找到和你志同道合的人的。",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "67icf",
            "text":
                "在那个小组里，莉莱很快的认识到了很多和自己有这同样问题的女生，她们大多有着和自己相同的经历。莉莱很开心能够来到这里，原来世界不只是自己有着这样的遭遇。莉莱在一次见面会上说道：”谢谢你 米拉娜，谢谢你露娜，谢谢你卓尔飞侠，谢谢你邪影芳龄，不是你们我不可能坚持下来。“说这便和其他的哦朋友一起",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          }
        ],
        "entityMap": {}
      };

      var converter = Converter(plugins: [TextPlugin()], draftData: data);

      var blocks = converter.convert();
      expect(blocks.length, 5);
      expect(blocks[0] is TextBlock, true);
    });
    test("convert with newline 2", () {
      var data = {
        "blocks": [
          {
            "key": "2mlhr",
            "text":
                "主持人： 欢迎各位年轻貌美的女性来到我们创造102的比赛现场。经过这次的激烈较量，选手们能够脱颖而出最后成为一个由24人组成的BKB48（Best king bitch 48) 组合。每个能进入决赛圈的选手，都会受到我们专业的导师的指导，出道。",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "4hqr6",
            "text": "",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "2teh1",
            "text": "各位导师：谢谢，你们都是最棒的女生，要相信自己。我也相信你们。祝好运。",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
        ],
        "entityMap": {}
      };

      var converter = Converter(plugins: [TextPlugin()], draftData: data);
      var blocks = converter.convert();
      expect(blocks.length, 3);
    });
  });

  group("Test convert image", () {
    test("Convert image 1", () {
      var data = {
        "blocks": [
          {
            "key": "69rah",
            "text": " ",
            "type": "atomic",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [
              {"offset": 0, "length": 1, "key": 0}
            ],
            "data": {}
          },
        ],
        "entityMap": {
          "0": {
            "type": "image",
            "mutability": "IMMUTABLE",
            "data": {
              "src":
                  "https://sirileepage-website-data.s3.amazonaws.com/static/image/2020/06/25/cover-13.png",
              "id": 51,
              "alignment": "center",
              "description": "2077 Art Online 示意图"
            }
          }
        }
      };

      var converter =
          Converter(plugins: [TextPlugin(), ImagePlugin()], draftData: data);
      var blocks = converter.convert();

      expect(blocks.length, 1);
      expect(blocks[0] is ImageBlock, true);
    });
  });
  group("Test convert header", () {
    test("1", () {
      var data = {
        "blocks": [
          {
            "key": "37nnb",
            "text": "最初的世界",
            "type": "header-one",
            "depth": 0,
            "inlineStyleRanges": [
              {"offset": 0, "length": 6, "style": "BOLD"}
            ],
            "entityRanges": [],
            "data": {}
          },
        ],
        "entityMap": {}
      };

      var converter = Converter(plugins: [
        HeaderPlugin(),
        TextPlugin(),
      ], draftData: data);
      var blocks = converter.convert();

      expect(blocks.length, 1);
      expect(blocks[0] is HeaderBlock, true);
      expect(blocks[0].children?.length, 1);
    });
  });

  group("Test convert blockquote", () {
    test("convert blockquote", () {
      var data = {
        "blocks": [
          {
            "key": "37nnb",
            "text": "最初的世界",
            "type": "header-one",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "aqk4s",
            "text": "我要灰原哀成为我老婆！",
            "type": "blockquote",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [
              {"offset": 2, "length": 3, "key": 9}
            ],
            "data": {}
          },
        ],
        "entityMap": {
          "9": {
            "type": "POST-SETTINGS",
            "mutability": "SEGMENTED",
            "data": {"id": "2b5bf9e4-e28d-4710-a0eb-9c0d9bc10679"}
          },
        }
      };

      var converter = Converter(
          plugins: [BlockQuotePlugin(), TextPlugin()], draftData: data);

      var blocks = converter.convert();
      expect(blocks.length, 3);
      expect(blocks[2].children?.length, 3);
    });

    test("convert blockquote 2", () {
      var data = {
        "blocks": [
          {
            "key": "2u035",
            "text": "这是哪里？好亮",
            "type": "blockquote",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
        ],
        "entityMap": {}
      };

      var converter = Converter(
          plugins: [BlockQuotePlugin(), TextPlugin()], draftData: data);

      var blocks = converter.convert();
      expect(blocks.length, 1);
      expect(blocks[0].children?.length, 0);
    });
  });

  group("Convert oredered list item", () {
    test("simple convertion", () {
      var data = {
        "blocks": [
          {
            "key": "2ipob",
            "text": "a",
            "type": "ordered-list-item",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "cgv2a",
            "text": "b",
            "type": "ordered-list-item",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "4ingg",
            "text": "c",
            "type": "ordered-list-item",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "40nct",
            "text": "d",
            "type": "ordered-list-item",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
        ],
        "entityMap": {}
      };

      var converter = Converter(plugins: [ListPlugin()], draftData: data);
      var blocks = converter.convert().map((e) => e as ListBlock).toList();
      expect(blocks.length, 4);
      expect(blocks[0].order, 1);
      expect(blocks[1].order, 2);
      expect(blocks[2].order, 3);
      expect(blocks[3].order, 4);

      expect(blocks[0].depth, 0);
      expect(blocks[1].depth, 0);
      expect(blocks[2].depth, 0);
      expect(blocks[3].depth, 0);
    });

    test("Multilevel convertion", () {
      /// a
      /// b c
      /// d
      var data = {
        "blocks": [
          {
            "key": "2ipob",
            "text": "a",
            "type": "ordered-list-item",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "cgv2a",
            "text": "b",
            "type": "ordered-list-item",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "4ingg",
            "text": "c",
            "type": "ordered-list-item",
            "depth": 1,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "40nct",
            "text": "d",
            "type": "ordered-list-item",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
        ],
        "entityMap": {}
      };

      var converter = Converter(plugins: [ListPlugin()], draftData: data);
      var blocks = converter.convert().map((e) => e as ListBlock).toList();
      expect(blocks.length, 4);
      expect(blocks[0].order, 1);
      expect(blocks[1].order, 2);
      expect(blocks[2].order, 1);
      expect(blocks[3].order, 3);

      expect(blocks[0].depth, 0);
      expect(blocks[1].depth, 0);
      expect(blocks[2].depth, 1);
      expect(blocks[3].depth, 0);
    });
  });

  group("Test Convert link", () {
    test("Simple link", () {
      var data = {
        "blocks": [
          {
            "key": "c376o",
            "text": "Hello world",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [
              {"offset": 0, "length": 40, "style": "#4caf50"}
            ],
            "entityRanges": [
              {"offset": 0, "length": 5, "key": 0},
            ],
            "data": {}
          },
        ],
        "entityMap": {
          "0": {
            "type": "LINK",
            "mutability": "MUTABLE",
            "data": {
              "url": {
                "link":
                    "https://news.delta.com/more-flights-service-return-july-delta-continues-industry-leading-safety-measures",
                "title":
                    "More flights, service return in July as Delta continues industry-leading safety measures | Delta News Hub",
                "image":
                    "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
                "summary": "Sign up for Delta News"
              }
            }
          },
        }
      };

      var converter = Converter(plugins: [LinkPlugin()], draftData: data);
      var blocks = converter.convert();
      expect(blocks.length, 2);
      expect(blocks[0] is LinkBlock, true);
      expect(blocks[0].data['url']['link'],
          "https://news.delta.com/more-flights-service-return-july-delta-continues-industry-leading-safety-measures");
    });
  });

  group("Test convert audio", () {
    test("simple convert", () {
      var data = {
        "blocks": [
          {
            "key": "45hi1",
            "text": " ",
            "type": "atomic",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [
              {"offset": 0, "length": 1, "key": 0}
            ],
            "data": {}
          },
        ],
        "entityMap": {
          "0": {
            "type": "audio",
            "mutability": "IMMUTABLE",
            "data": {"src": "abc.com"}
          },
        }
      };
      var converter = Converter(plugins: [AudioPlugin()], draftData: data);
      var blocks = converter.convert();
      expect(blocks.length, 1);
      expect(blocks[0].data['src'], "abc.com");
    });
  });
}
