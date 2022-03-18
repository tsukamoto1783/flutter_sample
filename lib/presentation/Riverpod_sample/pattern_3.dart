import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'counter_model.dart';

class ReverpodSample3 extends StatelessWidget {
  const ReverpodSample3({Key? key}) : super(key: key);

  @override
  // ↓model内の情報は「ref」を参照して渡される
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod テスト'),
      ),
      body: Center(
        child: Consumer(builder: (context, ref, _) {
          // Modelを読み込み
          final countModel = ref.read(counterProvider);
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
              TextButton(
                child: Text("+"),
                onPressed: countModel.incrementCounter,
              ),
              FloatingActionButton(
                onPressed: countModel.incrementCounter,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          );
        }),
      ),

      // ↓この階層だと、refを参照できないから、model内の関数を呼び出せない
      // floatingActionButton: FloatingActionButton(
      //   onPressed: countModel.incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
