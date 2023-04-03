import 'package:characters/characters.dart';

extension CompatableSubstring on String {
  List<String> get charList => characters.toList();

  String compatSubstring(int start, [int? end]) =>
      charList.sublist(start, end).join();

  int get compatLength => charList.length;
}
