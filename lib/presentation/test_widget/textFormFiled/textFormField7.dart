import 'package:flutter/material.dart';

class TextFormFieldSample7 extends StatelessWidget {
  const TextFormFieldSample7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? _formText;

    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'name',
                hintText: 'Enter your name',
              ),
              onChanged: (value) {
                _formText = value;
              },
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                print(_formText);
              },
            ),
          ],
        ),
      ),
    );
  }
}
