import 'package:flutter/cupertino.dart';

import 'base_block.dart';

typedef void OnTap(BaseBlock block);
typedef void OnDoubleTap(BaseBlock block);
typedef void OnLongPress(BaseBlock block);
typedef List<CupertinoContextMenuAction> ActionBuilder(BaseBlock block);
