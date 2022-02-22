import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/presentation/new/add_book/add_book_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../domain/book.dart';
import '../edit_book/edit_book_page.dart';
import 'book_list_model.dart';

class BookListPageNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = books
                .map(
                  (book) => Slidable(
                    child: ListTile(
                      leading: book.imgURL != null
                          ? Image.network(
                              book.imgURL!,
                              height: 75,
                              width: 75,
                              fit: BoxFit.fitHeight,
                            )
                          : null,
                      title: Text(book.title),
                      subtitle: Text(book.author),
                    ),
                    endActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(onDismissed: () {}),

                      // All actions are defined in the children parameter.
                      children: [
                        // A SlidableAction can have an icon and/or a label.
                        SlidableAction(
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: '削除',
                            onPressed: (BuildContext cotext) async {
                              // 削除しますか？って聞いて、はいだったら削除
                              await showConfirmDialog(context, book, model);
                            }),
                        SlidableAction(
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: '編集',
                          onPressed: (BuildContext context) async {
                            // 編集画面に遷移
                            final String? title = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBookPage(book),
                                fullscreenDialog: true,
                              ),
                            );
                            if (title != null) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('$titleを編集しました'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            model.fetchBookList();
                          },
                        ),
                      ],
                    ),
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              // 画面遷移
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );

              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('本を追加しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              model.fetchBookList();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }
}

Future showConfirmDialog(
  BuildContext context,
  Book book,
  BookListModel model,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        title: Text("削除の確認"),
        content: Text("『${book.title}』を削除しますか？"),
        actions: [
          TextButton(
            child: Text("いいえ"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("はい"),
            onPressed: () async {
              // modelで削除
              await model.delete(book);
              Navigator.pop(context);
              final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text('${book.title}を削除しました'),
              );
              model.fetchBookList();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      );
    },
  );
}
