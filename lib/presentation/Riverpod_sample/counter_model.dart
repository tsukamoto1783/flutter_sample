import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 状態管理表示部分（Model側）を作る
final counterProvider = ChangeNotifierProvider<CountModel>(
      (ref) => CountModel(),
);

class CountModel extends ChangeNotifier {
  int state = 0;

  void incrementCounter() {
    state++;
    notifyListeners();
  }
}
