import 'package:flutter/material.dart';

class TextFormFieldSample5 extends StatefulWidget {
  const TextFormFieldSample5({Key? key}) : super(key: key);

  @override
  State<TextFormFieldSample5> createState() => _TextFormFieldSampleState();
}

class _TextFormFieldSampleState extends State<TextFormFieldSample5> {
  // Controllerの定義
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // ウィジェットが破棄されるタイミングで、Controllerも破棄する。
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
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
              decoration: const InputDecoration(
                labelText: 'name',
                hintText: 'Enter your name',
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'email',
                hintText: 'Enter your email',
              ),
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                // 入力フォーム外からテキストの管理可能
                _nameController.text = "test Name";
                _emailController.text = "test Email";
              },
            ),
          ],
        ),
      ),
    );
  }
}
