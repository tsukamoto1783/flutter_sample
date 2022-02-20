import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/book.dart';
import '../add_book/add_book_page.dart';
import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();

    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("一覧"),
        ),

        // getを用いたItems取得
        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            final books = model.books;
            final listTiles = books
                .map(
                  (book) => ListTile(
                    title: Text(book.title),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),

                      // 更新処理
                      onPressed: () async {
                        // todo: 更新画面へ遷移
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBookPage(book),
                            fullscreenDialog: true,
                          ),
                        );
                        model.fetchBooks();
                      },
                    ),

                    // 削除処理
                    onLongPress: () async {
                      // todo: 削除画面へ遷移
                      await showDialog(
                          context: context,
                          builder: (BuildContext conetxt) {
                            return AlertDialog(
                              title: Text('${book.title}削除しますか？'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // todo:削除のAPIを叩く
                                    deleteBook(context, model, book);
                                  },
                                )
                              ],
                            );
                          });
                    },
                  ),
                )
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),

            // 追加処理
            onPressed: () async {
              // todo:Item新規登録画面へ遷移
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );
              model.fetchBooks();
            },
          );
        }),

        // ↓snapshotを用いたサンプル
        // body: StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance.collection('books').snapshots(),
        //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //
        //     // Errorハンドリング
        //     if (snapshot.hasError)
        //       return Text('Error: ${snapshot.error}');
        //
        //     switch (snapshot.connectionState) {
        //     // LodingMesage
        //       case ConnectionState.waiting:
        //         return Text('Loading...');
        //       default:
        //       // DB表示
        //         return ListView(
        //           children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //             Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        //             return ListTile(
        //               title: Text(data["title"]),
        //             );
        //           }).toList(),
        //         );
        //     }
        //   },
        // ),
      ),
    );
  }
}

Future deleteBook(BuildContext context, BookListModel model, Book book) async {
  try {
    await model.deleteBook(book);
    await showDialog(
        context: context,
        builder: (BuildContext conetxt) {
          return AlertDialog(
            title: Text('削除しました'),
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
    await model.fetchBooks();
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
