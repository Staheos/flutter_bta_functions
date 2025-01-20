import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';


loadQuestionsAsset(String category, String level) async {
  return await rootBundle.loadString('assets/questions/$category/$level.json');
}

getRandomQuestions(String category, String level, int count) async {
  String data = await loadQuestionsAsset(category, level);
  Map<String, dynamic> questions = jsonDecode(data);
  return getRandomElementsMap(questions, count);
}

List<T> getRandomElements<T>(List<T> list, int count) {
  if (count > list.length) {
    throw ArgumentError("Count is greater than map length");
  }
  List<T> res = [];
  Set<int> used = {};
  while (res.length < count) {
    int idx = Random().nextInt(list.length);
    if (!used.contains(idx)) {
      res.add(list[idx]);
      used.add(idx);
    }
  }
  return res;
}

Map<K, V> getRandomElementsMap<K, V>(Map<K, V> list, int count) {
  if (count > list.length) {
    throw ArgumentError("Count is greater than container length!");
  }
  Map<K, V> res = {};
  Set<int> used = {};
  while (res.length < count) {
    int idx = Random().nextInt(list.length);
    if (!used.contains(idx)) {
      res[list.keys.elementAt(idx) as K] = (list.values.elementAt(idx) as V);
      used.add(idx);
    }
  }
  return res;
}

List<List<T>> getMultipleRandomElements<T>(List<List<T>> lists, int count) {
  int listLength = lists[0].length;
  for (var list in lists) {
    if (listLength != list.length) {
      throw ArgumentError("Lists have different lengths!");
    }
  }
  for (var list in lists) {
    if (count > list.length) {
      throw ArgumentError("Count is greater than map length!");
    }
  }
  List<List<T>> res = [];
  Set<int> used = {};
  while (res[0].length < count) {
    int idx = Random().nextInt(lists[0].length);
    if (!used.contains(idx)) {
      for (int i = 0; i < lists.length; i++) {
        res[i].add(lists[i][idx]);
      }
      used.add(idx);
    }
  }
  return res;
}