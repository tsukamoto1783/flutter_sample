import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'counter_model.dart';

class ReverpodSample2 extends ConsumerWidget {
  const ReverpodSample2({Key? key}) : super(key: key);

  @override
  // ↓model内の情報は「ref」を参照して渡される
  Widget build(BuildContext context, WidgetRef ref) {
    // Modelを読み込み
    final countModel = ref.read(counterProvider);
    final counter = ref.watch(counterProvider).state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod テスト'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'クリックの回数',
            ),
            // 取得したデータを表示する
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: countModel.incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
