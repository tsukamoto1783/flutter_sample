import 'package:flutter/material.dart';
import '../../main.dart';
import 'pattern_1.dart';
import 'pattern_2.dart';
import 'pattern_3.dart';
import 'pattern_4.dart';

class RiverpodMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Riverpod Sample"),
        ),
        body: Menu());
  }
}

// 画面遷移をする部分のコード
class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextBtnNextPage(btn_text: "Smaple1", page_name: ReverpodSample1()),
          TextBtnNextPage(btn_text: "Smaple2", page_name: ReverpodSample2()),
          TextBtnNextPage(btn_text: "Smaple3", page_name: ReverpodSample3()),
          TextBtnNextPage(btn_text: "Smaple4", page_name: ReverpodSample4()),
        ],
      ),
    );
  }
}
