import 'package:flutter/material.dart';

class TextFormFieldSample4 extends StatefulWidget {
  const TextFormFieldSample4({Key? key}) : super(key: key);

  @override
  State<TextFormFieldSample4> createState() => _TextFormFieldSampleState();
}

class _TextFormFieldSampleState extends State<TextFormFieldSample4> {
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
            // controllerプロパティの指定
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'name',
                hintText: 'Enter your name',
              ),
            ),
            TextFormField(
              // controllerプロパティの指定
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
                print(_nameController.text);
                print(_emailController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
