import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../add_book/add_book_page.dart';
import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(); // new
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("一覧"),
        ),

        // getを用いたサンプル
        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            final books = model.books;
            final listTiles = books
                .map(
                  (book) => ListTile(
                    title: Text(book.title),
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
            onPressed: () async {
              // data追加
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
