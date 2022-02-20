import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/book.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitel = '';

  Future addBookFirebase() async {
    if (bookTitel.isEmpty) {
      throw ('タイトルを入力してください');
    }
    FirebaseFirestore.instance.collection('books').add({
      'title': bookTitel,
    });
  }

  Future updateBook(Book book) async {
    final document =
        FirebaseFirestore.instance.collection('books').doc(book.documentID);
    await document.update(
      {
        'title': bookTitel,
      },
    );
  }
}
