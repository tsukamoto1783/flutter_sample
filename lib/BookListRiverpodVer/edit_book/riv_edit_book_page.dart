import 'package:flutter/material.dart';
import '../domain/riv_book.dart';
import 'riv_edit_book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditBookPage extends StatelessWidget {
  final Book book;
  EditBookPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('本を編集'),
      ),
      body: Center(
        child: edit_book_body(book),
      ),
    );
  }
}

class edit_book_body extends ConsumerWidget {
  final Book book;
  edit_book_body(this.book);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final edit_book_ins = ref.watch(edit_book_Provider(book));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: edit_book_ins.titleController,
            decoration: InputDecoration(
              hintText: '本のタイトル',
            ),
            onChanged: (text) {
              edit_book_ins.setTitle(text);
            },
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            controller: edit_book_ins.authorController,
            decoration: InputDecoration(
              hintText: '本の著者',
            ),
            onChanged: (text) {
              edit_book_ins.setAuthor(text);
            },
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: edit_book_ins.isUpdated()
                ? () async {
                    // 追加の処理
                    try {
                      await edit_book_ins.update();
                      Navigator.of(context).pop(edit_book_ins.title);
                    } catch (e) {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(e.toString()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                : null,
            child: Text('更新する'),
          ),
        ],
      ),
    );
  }
}
