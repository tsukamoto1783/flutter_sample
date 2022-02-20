import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/domain/book.dart';
import 'package:flutter_practice/presentation/add_book/add_book_model.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage([this.book]);
  final book;

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    final bool isUpdate = book != null;
    final textEditiongController = TextEditingController();
    if (isUpdate) {
      textEditiongController.text = book.title;
    }

    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? "編集" : '追加'),
        ),
        body: Consumer<AddBookModel>(
          builder: (context, model, child) {
            return Column(
              children: <Widget>[
                TextField(
                  controller: textEditiongController,
                  onChanged: (text) {
                    model.bookTitel = text;
                  },
                ),
                RaisedButton(
                  child: Text(isUpdate ? "編集" : '追加'),
                  onPressed: () async {
                    if (isUpdate) {
                      await updateBook(model, context, book);
                    } else {
                      // firestoreに追加処理
                      await addBook(model, context);
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Future addBook(AddBookModel model, BuildContext context) async {
  try {
    await model.addBookFirebase();
    await showDialog(
        context: context,
        builder: (BuildContext conetxt) {
          return AlertDialog(
            title: Text('保存'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    Navigator.of(context).pop();
  } catch (e) {
    showDialog(
        context: context,
        builder: (BuildContext conetxt) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  } // try-catch
}

Future updateBook(AddBookModel model, BuildContext context, Book book) async {
  try {
    await model.updateBook(book);
    await showDialog(
        context: context,
        builder: (BuildContext conetxt) {
          return AlertDialog(
            title: Text('更新しました'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    Navigator.of(context).pop();
  } catch (e) {
    showDialog(
        context: context,
        builder: (BuildContext conetxt) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  } // try-catch
}
