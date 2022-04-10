import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firestore_model.dart';

class Firesoter_sample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("マイページ"),
        ),
        body: Firesoter_sample_model());
  }
}

class Firesoter_sample_model extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestore_items_ins = ref.watch(itemsProvider.notifier);
    firestore_items_ins.set();
    var tmp = firestore_items_ins.doc_value_array;
    print("↓print");
    print(tmp);
    print(tmp[0]['title']);

    var hoge = tmp[0]['title'];
    print(hoge);

    return Text("test");
  }
}
