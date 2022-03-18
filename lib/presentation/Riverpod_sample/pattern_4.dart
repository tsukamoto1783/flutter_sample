import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// modelで機能を分けずに完結させたパターン

// Providers are declared globally and specify how to create a state
// ( プロバイダはグローバルに宣言され、状態を作成する方法を指定します)
final counterProvider = StateProvider((ref) => 0);

class ReverpodSample4 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        // Consumer is a widget that allows you reading providers.
        // (Consumerは、プロバイダを読み込むことができるウィジェットです)
        child: Consumer(builder: (context, ref, _) {
          final count = ref.watch(counterProvider.state).state;
          return Text('$count');
        }),
      ),
      floatingActionButton: FloatingActionButton(
        // The read method is a utility to read a provider without listening to it
        // (readメソッドは、プロバイダをリッスンせずに読み込むためのユーティリティです)
        onPressed: () => ref.read(counterProvider.state).state++,
        // readで値を読み込んでインクリメント ⇛ 15行目でwatchが値の変化を監視しているので、検知してUIへ反映
        child: const Icon(Icons.add),
      ),
    );
  }
}
