import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/presentation/old/book_list/book_list_page.dart';
import 'package:provider/provider.dart';
import '../new/book_list/book_list_page.dart';
import 'main_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(); // new
    return MaterialApp(
      title: "Flutter App",
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("hogehoge"),
          ),
          body: Consumer<MainModel>(builder: (context, model, child) {
            return Center(
              child: Column(
                children: [
                  Text(
                    model.my_text,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  TextButton(
                    child: Text("Btn"),
                    onPressed: () {
                      // ここでなにかの処理
                      Navigator.push(
                        context,
                        // ↓ old:getでのbookListパターン
                        //MaterialPageRoute(builder: (context) => BookListPage()),

                        // ↓ new:snapshotでのbookListパターン
                        MaterialPageRoute(
                            builder: (context) => BookListPageNew()),
                      );
                    },
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
