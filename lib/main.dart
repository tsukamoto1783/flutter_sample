import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/presentation/fl_chart/line_chart_sample2.dart';
import 'package:flutter_practice/presentation/test_widget/Picker.dart';
import 'package:flutter_practice/presentation/test_widget/textFormFiled/textFormField4.dart';
import 'package:flutter_practice/presentation/test_widget/textFormFiled/textFormField2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'presentation/Riverpod_sample/Riverpod_menu.dart';
import 'presentation/State_test/state.dart';
import 'presentation/State_test/state_2.dart';
import 'presentation/Riverpod_sample/todo_main.dart';
import 'presentation/fl_chart/bar_chart_sample1.dart';
import 'presentation/fl_chart/bar_chart_sample2.dart';
import 'presentation/test_widget/DateTime.dart';
import 'presentation/test_widget/dropdown1.dart';
import 'presentation/test_widget/dropdown2.dart';
import 'presentation/test_widget/macos_doc.dart';
import 'presentation/test_widget/mouseRegion.dart';
import 'presentation/test_widget/textFormFiled/textFormFieldHome.dart';

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
            title: const Text("List of Test Pages"),
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
      child: SingleChildScrollView(
        child: Column(
          children: [
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
            TextBtnNextPage(
                btn_text: "fl_chart_1", page_name: BarChartSample7()),
            TextBtnNextPage(
                btn_text: "fl_chart_2", page_name: BarChartSample3()),
            TextBtnNextPage(
                btn_text: "fl_line_chart_sample_2",
                page_name: LineChartSample2()),
            TextBtnNextPage(
                btn_text: "Picker_sample", page_name: PickerSample()),
            TextBtnNextPage(
                btn_text: "MacOsInspired", page_name: MacOsInspiredDoc()),
            TextBtnNextPage(btn_text: "mouseRegion", page_name: mouseRegion()),
            TextBtnNextPage(
                btn_text: "TextFormField",
                page_name: const TextFormFieldHome()),
          ],
        ),
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
