import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'counter_model.dart';

// ↓model内の情報は「ref」を参照して渡される

// 表示部分（ページ側）を作る
// class MyHomePage extends  StatelessWidget{
class ReverpodSample1 extends ConsumerWidget {
  @override
  // Widget build(BuildContext context) {
  Widget build(BuildContext context, WidgetRef ref) {
    // Modelを読み込み
    // final countModel = context.read(counterProvider);
    final countModel = ref.read(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod テスト'),
      ),
      // bodyの表示
      body: Center(
        // child: Consumer(builder: (context, watch, _) {
        child: Consumer(builder: (context, ref, _) {
          // データを取得する
          // final counter = watch(counterProvider).state;
          final counter = ref.watch(counterProvider).state;

          return Column(
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
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: countModel.incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
