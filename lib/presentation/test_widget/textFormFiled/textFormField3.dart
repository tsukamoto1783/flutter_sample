import 'package:flutter/material.dart';

/// 以下、上手く行かない例
///
class TextFormFieldSample3 extends StatefulWidget {
  const TextFormFieldSample3({Key? key}) : super(key: key);

  @override
  State<TextFormFieldSample3> createState() => _TextFormFieldSampleState();
}

class _TextFormFieldSampleState extends State<TextFormFieldSample3> {
  // TextFormFieldウィジェットを一意に識別するためのグローバルキーを作成
  // NOTE:
  // GlobalKeyをTextFormFieldに指定することはできるが、思ったような動作にはならない。（非推奨）
  // 基本的にはGlobalKeyを用いてのフォーム管理はFromウィジェットで使用する。
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              key: _nameKey,
              decoration: const InputDecoration(
                labelText: 'name',
                hintText: 'Enter your name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                print('The saved name is $value');
              },
            ),
            TextFormField(
              key: _emailKey,
              decoration: const InputDecoration(
                labelText: 'email',
                hintText: 'Enter your email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                print('The saved email is $value');
              },
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                // 以下の部分でエラーが発生する
                if (_nameKey.currentState!.validate()) {
                  _nameKey.currentState?.save();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
