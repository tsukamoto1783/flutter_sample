import 'package:flutter/material.dart';
import '../add_book/riv_add_book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddBookPage extends StatelessWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本を追加'),
      ),
      body: Center(
        child: add_book_body(),
      ),
    );
  }
}

class add_book_body extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final add_book_ins = ref.watch(add_book_Provider);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // ↓Image Registration Form
              GestureDetector(
                child: SizedBox(
                  width: 100,
                  height: 160,
                  child: add_book_ins.imageFile != null
                      ? Image.file(add_book_ins.imageFile!)
                      : Container(
                          color: Colors.grey,
                        ),
                ),
                onTap: () async {
                  await add_book_ins.pickImage();
                },
              ),

              // ↓Title Registration Form
              TextField(
                decoration: const InputDecoration(
                  hintText: '本のタイトル',
                ),
                onChanged: (text) {
                  add_book_ins.title = text;
                },
              ),
              const SizedBox(
                height: 8,
              ),

              // ↓Author Registration Form
              TextField(
                decoration: const InputDecoration(
                  hintText: '本の著者',
                ),
                onChanged: (text) {
                  add_book_ins.author = text;
                },
              ),
              const SizedBox(
                height: 16,
              ),

              // ↓Add button processing
              ElevatedButton(
                onPressed: () async {
                  try {
                    add_book_ins.startLoading();
                    await add_book_ins.addBook();
                    Navigator.of(context).pop(true);
                  } catch (e) {
                    print(e);
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } finally {
                    add_book_ins.endLoading();
                  }
                },
                child: const Text('追加する'),
              ),
            ],
          ),
        ),

        // ↓Loading animation
        if (add_book_ins.isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
