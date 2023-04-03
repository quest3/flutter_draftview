import 'dart:convert';

const Map<String, dynamic> data = {
  "blocks": [
    {"key": "fpjc9", "text": "Liyue", "type": "header-one", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {
      "key": "3jucn",
      "text": "Liyue (Chinese: 璃月 Líyuè) is one of the seven regions in Teyvat. It is the city-state that worships Rex Lapis, the Geo Archon.",
      "type": "unstyled",
      "depth": 0,
      "inlineStyleRanges": [
        {"offset": 0, "length": 5, "style": "BOLD"},
        {"offset": 7, "length": 7, "style": "UNDERLINE"},
        {"offset": 19, "length": 5, "style": "ITALIC"}
      ],
      "entityRanges": [
        {"offset": 57, "length": 6, "key": 0},
        {"offset": 100, "length": 9, "key": 1},
        {"offset": 115, "length": 3, "key": 2},
        {"offset": 119, "length": 6, "key": 3}
      ],
      "data": {}
    },
    {
      "key": "c1oth",
      "text": "Access to Liyue is unlocked after completing the Archon Quest Prologue: Act I - The Outlander Who Caught the Wind.",
      "type": "unstyled",
      "depth": 0,
      "inlineStyleRanges": [],
      "entityRanges": [
        {"offset": 49, "length": 12, "key": 4},
        {"offset": 62, "length": 8, "key": 5},
        {"offset": 80, "length": 33, "key": 6}
      ],
      "data": {}
    },
    {
      "key": "7lium",
      "text": "Archon Quest Chapter I: Farewell, Archaic Lord takes place in this region.",
      "type": "unstyled",
      "depth": 0,
      "inlineStyleRanges": [],
      "entityRanges": [
        {"offset": 13, "length": 9, "key": 7}
      ],
      "data": {}
    },
    {"key": "1n24f", "text": "", "type": "unstyled", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {
      "key": "df0t4",
      "text":
      "\"The God of Contracts, senselessly slaughtered as his people watched on in horror. In the end, he will sign the contract to end all contracts.\"",
      "type": "blockquote",
      "depth": 0,
      "inlineStyleRanges": [],
      "entityRanges": [],
      "data": {}
    },
    {
      "key": "819a8",
      "text": "—Dainsleif, Teyvat Chapter Storyline Preview: Travail",
      "type": "blockquote",
      "depth": 0,
      "inlineStyleRanges": [],
      "entityRanges": [
        {"offset": 1, "length": 9, "key": 8}
      ],
      "data": {}
    },
    {"key": "9nseh", "text": "", "type": "unstyled", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "9o218", "text": "Contents", "type": "header-two", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "647f9", "text": "Areas", "type": "ordered-list-item", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "erkj5", "text": "Subareas", "type": "ordered-list-item", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "2iqov", "text": "Characters", "type": "ordered-list-item", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "39uvd", "text": "Playable Characters", "type": "ordered-list-item", "depth": 1, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "bv6u8", "text": "Upcoming Characters", "type": "ordered-list-item", "depth": 1, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "6p0js", "text": "NPCs", "type": "ordered-list-item", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "132ke", "text": "Related NPCs", "type": "ordered-list-item", "depth": 1, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "6kloi", "text": "Mentioned Characters", "type": "ordered-list-item", "depth": 1, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "6ljps", "text": "Upcoming NPCs", "type": "ordered-list-item", "depth": 1, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "74i8s", "text": "Trivia", "type": "ordered-list-item", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "71pe6", "text": "Etymology", "type": "ordered-list-item", "depth": 1, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "4ret4", "text": "Cultural References", "type": "ordered-list-item", "depth": 1, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "8sel1", "text": "Gallery", "type": "ordered-list-item", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "9jiuk", "text": "Other Languages", "type": "ordered-list-item", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "5aina", "text": "Change History", "type": "ordered-list-item", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "cc51o", "text": "References", "type": "ordered-list-item", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "3n0lb", "text": "Navigation", "type": "ordered-list-item", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "81bpg", "text": "", "type": "unstyled", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "4deam", "text": "Areas", "type": "header-two", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "7ut09", "text": "", "type": "header-two", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {
      "key": "2efra",
      "text": " ",
      "type": "atomic",
      "depth": 0,
      "inlineStyleRanges": [],
      "entityRanges": [
        {"offset": 0, "length": 1, "key": 9}
      ],
      "data": {}
    },
    {
      "key": "15iif",
      "text": "Lisha",
      "type": "unstyled",
      "depth": 0,
      "inlineStyleRanges": [
        {"offset": 0, "length": 5, "style": "center"}
      ],
      "entityRanges": [
        {"offset": 0, "length": 5, "key": 10}
      ],
      "data": {}
    },
    {"key": "6qvo8", "text": "", "type": "unstyled", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {
      "key": "2povu",
      "text": " ",
      "type": "atomic",
      "depth": 0,
      "inlineStyleRanges": [],
      "entityRanges": [
        {"offset": 0, "length": 1, "key": 11}
      ],
      "data": {}
    },
    {
      "key": "b3rih",
      "text": "Sea of Clouds",
      "type": "unstyled",
      "depth": 0,
      "inlineStyleRanges": [
        {"offset": 0, "length": 13, "style": "center"}
      ],
      "entityRanges": [
        {"offset": 0, "length": 13, "key": 12}
      ],
      "data": {}
    },
    {"key": "bvp6p", "text": "", "type": "unstyled", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "9rqk9", "text": "Trivia", "type": "header-two", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {
      "key": "1tg93",
      "text": "Liyue is the most prosperous of the seven regions.",
      "type": "unordered-list-item",
      "depth": 0,
      "inlineStyleRanges": [],
      "entityRanges": [],
      "data": {}
    },
    {
      "key": "8pit",
      "text": "There is an area called Yilong Port in Liyue.[5] Its location is currently unknown.",
      "type": "unordered-list-item",
      "depth": 0,
      "inlineStyleRanges": [],
      "entityRanges": [
        {"offset": 45, "length": 3, "key": 13}
      ],
      "data": {}
    },
    {
      "key": "e9s5l",
      "text":
      "In the trailer Teyvat Chapter Storyline Preview: Travail, under the title of the quest Farewell, Archaic Lord, there is a line written in Teyvat's Latin script. It reads \"Ruat caelum fiat pactum,\" which roughly means \"Let the contract be made, though the heavens fall,\" and is modified from the phrase fiat justitia ruat caelum.",
      "type": "unordered-list-item",
      "depth": 0,
      "inlineStyleRanges": [
        {"offset": 15, "length": 41, "style": "ITALIC"},
        {"offset": 87, "length": 22, "style": "ITALIC"},
        {"offset": 171, "length": 23, "style": "ITALIC"},
        {"offset": 302, "length": 25, "style": "ITALIC"}
      ],
      "entityRanges": [
        {"offset": 15, "length": 41, "key": 14},
        {"offset": 87, "length": 22, "key": 15},
        {"offset": 147, "length": 12, "key": 16},
        {"offset": 302, "length": 25, "key": 17}
      ],
      "data": {}
    },
    {
      "key": "e1ens",
      "text":
      "As of Chapter I, Liyue is the only region to ostensibly not have a ruling archon at all, after Morax faked his death in the quest Rite of Descension.",
      "type": "unordered-list-item",
      "depth": 0,
      "inlineStyleRanges": [
        {"offset": 67, "length": 6, "style": "ITALIC"},
        {"offset": 130, "length": 18, "style": "ITALIC"}
      ],
      "entityRanges": [
        {"offset": 6, "length": 9, "key": 18},
        {"offset": 130, "length": 18, "key": 19}
      ],
      "data": {}
    },
    {"key": "5oprc", "text": "", "type": "atomic", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "1ciui", "text": "", "type": "unstyled", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {"key": "1u24e", "text": "References", "type": "header-two", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {
      "key": "9u2kg",
      "text": "NPC Idle Quote: Geri",
      "type": "ordered-list-item",
      "depth": 0,
      "inlineStyleRanges": [],
      "entityRanges": [
        {"offset": 16, "length": 4, "key": 20}
      ],
      "data": {}
    },
    {
      "key": "81lfc",
      "text":
      "Event Of Drink A-Dreaming World Quest: Surrounded by the Aroma of Tea\n\"What I shared with you today are mostly my own habits as an old-fashioned Liyue local.\"",
      "type": "ordered-list-item",
      "depth": 0,
      "inlineStyleRanges": [
        {"offset": 39, "length": 30, "style": "ITALIC"},
        {"offset": 70, "length": 88, "style": "ITALIC"}
      ],
      "entityRanges": [
        {"offset": 6, "length": 19, "key": 21},
        {"offset": 39, "length": 30, "key": 22}
      ],
      "data": {}
    },
    {
      "key": "6vtj2",
      "text": "NPC Dialogue: Chef Mao @Chef_mao",
      "type": "ordered-list-item",
      "depth": 0,
      "inlineStyleRanges": [],
      "entityRanges": [
        {"offset": 14, "length": 8, "key": 23}
      ],
      "data": {}
    },
    {"key": "6amuv", "text": "", "type": "unstyled", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}},
    {
      "key": "cagar",
      "text": "英雄出少年 Yīngxióng chū shàonián, lit. \"Heroes appear from youths.\"",
      "type": "code-block",
      "depth": 0,
      "inlineStyleRanges": [
        {"offset": 6, "length": 22, "style": "ITALIC"}
      ],
      "entityRanges": [],
      "data": {}
    },
    {"key": "e7js9", "text": "", "type": "unstyled", "depth": 0, "inlineStyleRanges": [], "entityRanges": [], "data": {}}
  ],
  "entityMap": {
    "0": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {"href": "https://genshin-impact.fandom.com/wiki/Teyvat", "title": "Teyvat", "url": "https://genshin-impact.fandom.com/wiki/Teyvat"}
    },
    "1": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {"href": "https://genshin-impact.fandom.com/wiki/Morax", "title": "Morax", "url": "https://genshin-impact.fandom.com/wiki/Morax"}
    },
    "2": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {"href": "https://genshin-impact.fandom.com/wiki/Geo", "title": "Geo", "url": "https://genshin-impact.fandom.com/wiki/Geo"}
    },
    "3": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {"href": "https://genshin-impact.fandom.com/wiki/Archon", "title": "Archon", "url": "https://genshin-impact.fandom.com/wiki/Archon"}
    },
    "4": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {
        "href": "https://genshin-impact.fandom.com/wiki/Archon_Quest",
        "title": "Archon Quest",
        "url": "https://genshin-impact.fandom.com/wiki/Archon_Quest"
      }
    },
    "5": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {"href": "https://genshin-impact.fandom.com/wiki/Prologue", "title": "Prologue", "url": "https://genshin-impact.fandom.com/wiki/Prologue"}
    },
    "6": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {
        "href": "https://genshin-impact.fandom.com/wiki/The_Outlander_Who_Caught_the_Wind",
        "title": "The Outlander Who Caught the Wind",
        "url": "https://genshin-impact.fandom.com/wiki/The_Outlander_Who_Caught_the_Wind"
      }
    },
    "7": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {"href": "https://genshin-impact.fandom.com/wiki/Chapter_I", "title": "Chapter I", "url": "https://genshin-impact.fandom.com/wiki/Chapter_I"}
    },
    "8": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {"href": "https://genshin-impact.fandom.com/wiki/Dainsleif", "title": "Dainsleif", "url": "https://genshin-impact.fandom.com/wiki/Dainsleif"}
    },
    "9": {
      "type": "IMAGE",
      "mutability": "IMMUTABLE",
      "data": {"src": "https://s3.us-west-1.amazonaws.com/quest3.beta/quest/713992465783177427.jpeg"}
    },
    "10": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {"href": "https://genshin-impact.fandom.com/wiki/Lisha", "title": "Lisha", "url": "https://genshin-impact.fandom.com/wiki/Lisha"}
    },
    "11": {
      "type": "IMAGE",
      "mutability": "IMMUTABLE",
      "data": {"src": "https://s3.us-west-1.amazonaws.com/quest3.beta/quest/713992480845975605.jpeg"}
    },
    "12": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {
        "href": "https://genshin-impact.fandom.com/wiki/Sea_of_Clouds",
        "title": "Sea of Clouds",
        "url": "https://genshin-impact.fandom.com/wiki/Sea_of_Clouds"
      }
    },
    "13": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {"href": "https://genshin-impact.fandom.com/wiki/Liyue#cite_note-5", "url": "https://genshin-impact.fandom.com/wiki/Liyue#cite_note-5"}
    },
    "14": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {
        "href": "https://genshin-impact.fandom.com/wiki/Teyvat_Chapter_Storyline_Preview:_Travail",
        "title": "Teyvat Chapter Storyline Preview: Travail",
        "url": "https://genshin-impact.fandom.com/wiki/Teyvat_Chapter_Storyline_Preview:_Travail"
      }
    },
    "15": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {
        "href": "https://genshin-impact.fandom.com/wiki/Farewell,_Archaic_Lord",
        "title": "Farewell, Archaic Lord",
        "url": "https://genshin-impact.fandom.com/wiki/Farewell,_Archaic_Lord"
      }
    },
    "16": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {
        "href": "https://genshin-impact.fandom.com/wiki/Latin-Based_Language",
        "title": "Latin-Based Language",
        "url": "https://genshin-impact.fandom.com/wiki/Latin-Based_Language"
      }
    },
    "17": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {
        "href": "http://en.wikipedia.org/wiki/fiat_justitia_ruat_caelum",
        "title": "wikipedia:fiat justitia ruat caelum",
        "url": "http://en.wikipedia.org/wiki/fiat_justitia_ruat_caelum"
      }
    },
    "18": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {"href": "https://genshin-impact.fandom.com/wiki/Chapter_I", "title": "Chapter I", "url": "https://genshin-impact.fandom.com/wiki/Chapter_I"}
    },
    "19": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {
        "href": "https://genshin-impact.fandom.com/wiki/Rite_of_Descension",
        "title": "Rite of Descension",
        "url": "https://genshin-impact.fandom.com/wiki/Rite_of_Descension"
      }
    },
    "20": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {
        "href": "https://genshin-impact.fandom.com/wiki/Geri#Idle_Quotes",
        "title": "Geri",
        "url": "https://genshin-impact.fandom.com/wiki/Geri#Idle_Quotes"
      }
    },
    "21": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {
        "href": "https://genshin-impact.fandom.com/wiki/Of_Drink_A-Dreaming",
        "title": "Of Drink A-Dreaming",
        "url": "https://genshin-impact.fandom.com/wiki/Of_Drink_A-Dreaming"
      }
    },
    "22": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {
        "href": "https://genshin-impact.fandom.com/wiki/Surrounded_by_the_Aroma_of_Tea",
        "title": "Surrounded by the Aroma of Tea",
        "url": "https://genshin-impact.fandom.com/wiki/Surrounded_by_the_Aroma_of_Tea"
      }
    },
    "23": {
      "type": "LINK",
      "mutability": "MUTABLE",
      "data": {
        "href": "https://genshin-impact.fandom.com/wiki/Chef_Mao#Dialogue",
        "title": "Chef Mao",
        "url": "https://genshin-impact.fandom.com/wiki/Chef_Mao#Dialogue"
      }
    }
  }
};
Map<String, dynamic> data2 = json.decode(
  "{\"blocks\":[{\"key\":\"93bar\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"fn4id\",\"text\":\" \",\"type\":\"atomic\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[{\"offset\":0,\"length\":1,\"key\":0}],\"data\":{}},{\"key\":\"cfhh8\",\"text\":\"https://www.leechprotocol.com/\",\"type\":\"header-one\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[{\"offset\":0,\"length\":30,\"key\":1}],\"data\":{}},{\"key\":\"2qess\",\"text\":\"\",\"type\":\"header-one\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"90s3l\",\"text\":\"🎉Rewards: 1000 USDT 🏆\",\"type\":\"header-one\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"a5aj6\",\"text\":\"100 prizes at 10 USDT each.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"11cvc\",\"text\":\"Event Period: March 28- April 11\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"17e7n\",\"text\":\"Don't forget to tell your friends about this! 💑\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"2f46\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"e2jm5\",\"text\":\"How to participate\",\"type\":\"header-two\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"7oqep\",\"text\":\"Retweet & like on Twitter :\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"343ph\",\"text\":\"📷Leech Protocol - Automated Yield Aggregator on Twitter\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[{\"offset\":0,\"length\":1,\"key\":2}],\"data\":{}},{\"key\":\"9rnu7\",\"text\":\"Follow :\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"6chdv\",\"text\":\"📷LeechProtocol\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[{\"offset\":0,\"length\":1,\"key\":3}],\"data\":{}},{\"key\":\"d9k0s\",\"text\":\"Join Discord:\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"eq58i\",\"text\":\"📷Join the Leech Protocol Discord Server!\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[{\"offset\":0,\"length\":1,\"key\":4}],\"data\":{}},{\"key\":\"dpegf\",\"text\":\"\",\"type\":\"header-two\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"3drjf\",\"text\":\"\",\"type\":\"header-two\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"er4ce\",\"text\":\"🎉About Leech Protocol (not yet launched)\",\"type\":\"header-two\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"23r5f\",\"text\":\"Yield farming is a critical component of #DeFi, but it requires users to constantly be vigilant, stay up-to-date on news, and avoid potential scams, all while employing sophisticated strategies to maximize APR.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"9eeh5\",\"text\":\"This level of dedication and technical know-how presents a significant challenge for many #crypto investors looking to participate in yield farming.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"nvp1\",\"text\":\"So we decided to create an #easyDeFi platform for them!\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"bc5rm\",\"text\":\"Leech Protocol provides a user-friendly solution that simplifies the yield farming process across all major blockchains and platforms, enabling users to efficiently earn in just a few clicks.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"bovum\",\"text\":\"Our platform effortlessly enables sophisticated strategies with\\nadvanced risk management techniques, allowing users to earn yields from all current and future platforms in the market.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"aiabf\",\"text\":\"Yes. You heard that right. Current and future🔥👇\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"6n79q\",\"text\":\"We are a one-stop shop for everyone who wants to enjoy their farming yields.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"f96fe\",\"text\":\"Our mission is to make #DeFi easy for everyone.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"eqdlu\",\"text\":\"How can we do that?\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"f1cvd\",\"text\":\"✅ Multichain Liquidity Management under the hood.\\n✅ Diversification, rebalancing, and risk management. All are fully automated and hidden from the user’s eyes.\\n✅ An easy interface that will allow non-DeFi users to interact with our product\\n✅ Sophisticated Farming strategies. Available to all, even newcomers, providing everyone with access to the techniques of financial corporations.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{\"0\":{\"type\":\"IMAGE\",\"mutability\":\"IMMUTABLE\",\"data\":{\"src\":\"https://s3.ap-northeast-1.amazonaws.com/quest3.xyz/quest/752041379628040343.jpg\"}},\"1\":{\"type\":\"LINK\",\"mutability\":\"MUTABLE\",\"data\":{\"url\":\"https://www.leechprotocol.com/\"}},\"2\":{\"type\":\"IMAGE\",\"mutability\":\"IMMUTABLE\",\"data\":{\"src\":\"https://abs.twimg.com/favicons/twitter.2.ico\"}},\"3\":{\"type\":\"IMAGE\",\"mutability\":\"IMMUTABLE\",\"data\":{\"src\":\"https://abs.twimg.com/favicons/twitter.2.ico\"}},\"4\":{\"type\":\"IMAGE\",\"mutability\":\"IMMUTABLE\",\"data\":{\"src\":\"https://discord.com/assets/ec2c34cadd4b5f4594415127380a85e6.ico\"}}}}",
);
