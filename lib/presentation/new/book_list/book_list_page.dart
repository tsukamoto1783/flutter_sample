import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/presentation/new/add_book/add_book_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../domain/book.dart';
import '../edit_book/edit_book_page.dart';
import '../login/login_page.dart';
import '../mypage/my_page.dart';
import 'book_list_model.dart';

class BookListPageNew extends StatelessWidget {
  const BookListPageNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('本一覧'),
          actions: [
            IconButton(
              // Screen transition to loginPage
              onPressed: () async {
                if (FirebaseAuth.instance.currentUser != null) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyPage(),
                        fullscreenDialog: true),
                  );
                } else {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                        fullscreenDialog: true),
                  );
                }
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return const CircularProgressIndicator();
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

                    //　Left swipe process
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: [
                        SlidableAction(
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: '削除',
                            onPressed: (BuildContext cotext) async {
                              // 削除しますか？って聞いて、はいだったら削除
                              await showConfirmDialog(context, book, model);
                            }),
                        SlidableAction(
                          backgroundColor: const Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: '編集',

                          // Screen transition to EditBookPage
                          onPressed: (BuildContext context) async {
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
            // Screen transition to AddBookPage
            onPressed: () async {
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddBookPage(),
                  fullscreenDialog: true,
                ),
              );

              if (added != null && added) {
                const snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('本を追加しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              model.fetchBookList();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
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
        title: const Text("削除の確認"),
        content: Text("『${book.title}』を削除しますか？"),
        actions: [
          TextButton(
            child: const Text("いいえ"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("はい"),
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
