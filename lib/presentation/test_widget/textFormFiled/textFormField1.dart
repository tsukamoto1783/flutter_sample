import 'package:flutter/material.dart';

/// GlobalKey + TextFormFiled一つ
/// StatefulでもStatelessでも動作は一緒
class TextFormFieldSample1 extends StatefulWidget {
  const TextFormFieldSample1({Key? key}) : super(key: key);

  @override
  State<TextFormFieldSample1> createState() => _TextFormFieldSampleState();
}

class _TextFormFieldSampleState extends State<TextFormFieldSample1> {
  // Formウィジェットを一意に識別するためのグローバルキーを作成。フォームのバリデーション等を可能に。
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'name',
                  hintText: 'Enter your name',
                ),
                validator: (value) {
                  // _formKey.currentState!.validate()が実行された時に呼び出される
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  // _formKey.currentState?.save()が実行されたときに呼び出される
                  print('The saved name is $value');
                },
              ),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  // TextFormFieldのvalidatorで指定したバリデーションを確認し、エラーが無ければtrueを返す
                  if (_formKey.currentState!.validate()) {
                    // フォームの状態を保存して、TextFormFieldのonSavedを呼び出し
                    _formKey.currentState?.save();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
