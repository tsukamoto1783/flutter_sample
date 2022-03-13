import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../State_test/Riverpod_counter.dart';
import '../State_test/state.dart';
import '../State_test/state_2.dart';
import '../State_test/todo_main.dart';
import '../new/book_list/book_list_page.dart';
import '../test_widget/DateTime.dart';
import '../test_widget/dropdown1.dart';
import '../test_widget/dropdown2.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ja');
    Firebase.initializeApp(); // new
    return MaterialApp(
      title: "Flutter App",
      home: Scaffold(
          appBar: AppBar(
            title: const Text("List of various test pages"),
          ),
          body: Home()),
    );
  }
}

// 画面遷移をする部分のコード
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            child: Text("To: BookListPage"),
            onPressed: () {
              Navigator.push(
                context,
                // ↓ new:snapshotでのbookListパターン
                MaterialPageRoute(builder: (context) => BookListPageNew()),
              );
            },
          ),
          TextButton(
            child: Text("Test: dropdwon1"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DropdownPage1()),
              );
            },
          ),
          TextButton(
            child: Text("Test: dropdwon2"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DropdownPage2()),
              );
            },
          ),
          TextButton(
            child: Text("Test: StatelfulWidget"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StateTestPage(title: 'hoge')),
              );
            },
          ),
          TextButton(
            child: Text("Test: StatefulWidget_2"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage_2()),
              );
            },
          ),
          TextButton(
            child: Text("Test: Riverpod Sample Counter"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReverpodSample()),
              );
            },
          ),
          TextButton(
            child: Text("Test: Riverpod Sample ToDo"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RiverpodTodo()),
              );
            },
          ),
          TextButton(
            child: Text("Test: DateTimeSample"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DateTimeSample()),
              );
            },
          ),
        ],
      ),
    );
  }
}
