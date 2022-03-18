import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../Riverpod_sample/Riverpod_menu.dart';
import '../State_test/state.dart';
import '../State_test/state_2.dart';
import '../Riverpod_sample/todo_main.dart';
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
          TextBtnNextPage(
              btn_text: "To: BookListPage", page_name: BookListPageNew()),
          TextBtnNextPage(btn_text: "dropdwon1", page_name: DropdownPage1()),
          TextBtnNextPage(btn_text: "dropdwon2", page_name: DropdownPage2()),
          TextBtnNextPage(
              btn_text: "StatelfulWidget",
              page_name: StateTestPage(title: "test StatelessWidget")),
          TextBtnNextPage(
              btn_text: "StatefulWidget_2", page_name: MyHomePage_2()),
          TextBtnNextPage(
              btn_text: "Riverpod Sample Counter", page_name: RiverpodMenu()),
          TextBtnNextPage(
              btn_text: "Riverpod Sample ToDo", page_name: RiverpodTodo()),
          TextBtnNextPage(
              btn_text: "DateTimeSample", page_name: DateTimeSample()),
        ],
      ),
    );
  }
}

class TextBtnNextPage extends StatelessWidget {
  TextBtnNextPage({required this.btn_text, this.page_name});

  final String btn_text;
  var page_name;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(btn_text),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page_name),
        );
      },
    );
  }
}
