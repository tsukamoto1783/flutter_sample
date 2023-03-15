import 'package:flutter/material.dart';
import 'package:flutter_practice/main.dart';
import 'package:flutter_practice/presentation/test_widget/textFormFiled/textFormField1.dart';
import 'package:flutter_practice/presentation/test_widget/textFormFiled/textFormField2.dart';
import 'package:flutter_practice/presentation/test_widget/textFormFiled/textFormField3.dart';

// 画面遷移をする部分のコード
class TextFormFieldHome extends StatelessWidget {
  const TextFormFieldHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextBtnNextPage(
                btn_text: "TextFormField1",
                page_name: const TextFormFieldSample1(),
              ),
              TextBtnNextPage(
                btn_text: "TextFormField2",
                page_name: const TextFormFieldSample2(),
              ),
              TextBtnNextPage(
                btn_text: "TextFormField3",
                page_name: TextFormFieldSample3(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
