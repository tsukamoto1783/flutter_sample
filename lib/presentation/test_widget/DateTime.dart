import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeSample extends StatelessWidget {
  static const String _title = 'DateTime Sample';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: Center(
        child: MyStatelesWidget(),
      ),
    );
  }
}

class MyStatelesWidget extends StatelessWidget {
  MyStatelesWidget({Key? key}) : super(key: key);
  DateTime now = DateTime.now();

  // nowのままだとDateTime型なので、表示ができないので、DateFormatでStringに変換
  // DateFormatも色々な表示が可能、以下抜粋
  String time = DateFormat('yyyy/MM/dd(E)').format(DateTime.now());
  // "ja"表記にするならmain処理の前にinitialize処理が必要。標準はUS表記なので。
  String time_ja = DateFormat('yyyy/MM/dd(E)', "ja").format(DateTime.now());
  String hoge = DateFormat.yMMMEd('ja').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Center(
            child: Text(time),
          ),
          Center(
            child: Text(time_ja),
          ),
          Center(
            child: Text(hoge),
          ),
        ],
      ),
    );
  }
}
