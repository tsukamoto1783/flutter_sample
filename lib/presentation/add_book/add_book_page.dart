import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/presentation/add_book/add_book_model.dart';
import 'package:flutter_practice/presentation/add_book/add_book_model.dart';
import 'package:flutter_practice/presentation/add_book/add_book_model.dart';
import 'package:provider/provider.dart';

import '../book_list/book_list_model.dart';

class AddBookPage extends StatelessWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(); // new
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("追加"),
        ),
        body: Consumer<AddBookModel>(
          builder: (context, model, child) {
            return Column(
              children: <Widget>[
                TextField(
                  onChanged: (text) {
                    model.bookTitel = text;
                  },
                ),
                RaisedButton(
                  child: Text('追加する'),
                  onPressed: () async {
                    // firestoreに追加処理
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
