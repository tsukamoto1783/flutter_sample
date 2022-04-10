/// ToDO
/// ・Riverpod化
/// ・DBからアイテム取得処理
/// ⇛それができたら、動的にグラフの値を表示できるように調整。
/// 　・barタイトルの表示
/// 　・時間の合計を表示
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

/// 値取得のclass
final itemsProvider =
    StateNotifierProvider<RecordNotifier, String>((ref) => RecordNotifier());
// final ins_Provider = Provider((ref) => RecordNotifier());

class RecordNotifier extends StateNotifier<String> {
  RecordNotifier() : super("");
  final List doc_value_array = [];

  void set() async {
    /// Referenceはただの参照。(参照先の指定)
    // CollectionReference
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('books');
    print(collectionRef);

    // DocumentReference
    final DocumentReference docRef = FirebaseFirestore.instance
        .collection('books')
        .doc("2laNO7KW8ootDFQM0wNz"); // 適当なDocID
    print(docRef);

    /// Snapshot
    /// Reference(参照先)の中身の実態。get()で実態を取得できる。
    // CollectionReferenceに対して.get()すると、QuerySnapshot型に。
    final QuerySnapshot collection_snapshot = await collectionRef.get();
    print(collection_snapshot);

    // DocumentReferenceに対して.get()すると、DocumentSnapshot型に。
    final DocumentSnapshot doc_snapshot = await docRef.get();
    print(doc_snapshot);

    /// Snapshot(実態)から値を取り出す。
    // QuerySnapshot型からの値取得
    // ①コレクション配下のドキュメント全ての実態を.docsで配列として取得
    final List<QueryDocumentSnapshot> doc_snapshot_array =
        collection_snapshot.docs;
    print(doc_snapshot_array);

    // ②Listの各要素(各DocumentSnapshot)の値を.data()で取得
    // ↓forで回して全て取得Ver
    for (var doc_snapshot in doc_snapshot_array) {
      doc_value_array.add(doc_snapshot.data());
    }
    print(doc_value_array);

    // ↓直接forEachは良くないらしい。あまりよくわからないが、、
    // doc_snapshot_array.forEach((doc_snapshot) {
    //   doc_value_array.add(doc_snapshot.data());
    // });

    // DocumentSnapshot型からの値取得
    var doc_value = doc_snapshot.data();
    print("↓doc_value");
    print(doc_value);

    return;
  }
}
