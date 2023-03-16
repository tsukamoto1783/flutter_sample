import 'package:flutter/material.dart';

class TextFormFieldSample6 extends StatefulWidget {
  const TextFormFieldSample6({Key? key}) : super(key: key);

  @override
  State<TextFormFieldSample6> createState() => _TextFormFieldSampleState();
}

class _TextFormFieldSampleState extends State<TextFormFieldSample6> {
  // Controllerの定義
  final TextEditingController _nameController = TextEditingController();
  // バリデーションエラー表示用の変数定義
  String? _nameErrorText;

  // ウィジェットが破棄されるタイミングで、Controllerも破棄
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // バリデーションチェック関数
  void _validate() {
    setState(() {
      _nameErrorText = _validateText(_nameController.text);
    });
  }

  String? _validateText(String email) {
    if (email.isEmpty) {
      return 'フォームが空です';
    }
    return null;
  }

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
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'name',
                hintText: 'Enter your name',
                errorText: _nameErrorText,
              ),
              onChanged: (_) => _validate(),
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                print(_nameController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
