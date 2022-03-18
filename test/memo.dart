// class AddBookPage extends StatelessWidget {
//   AddBookPage([this.book]);
//   final book;
//
//   @override
//   Widget build(BuildContext context) {
//     Firebase.initializeApp(); // new
//
//     final bool isUpdate = book != null;
//     final textEditiongController = TextEditingController();
//
//     print(book);
//     if (isUpdate) {
//       textEditiongController.text = book.title;
//     }

/*
    変数の動的か静的かの判断。静的だとnullのときの処理がなかなかうまくいかず実装が進まない。動的だと比較的楽だが、テスト工程の時とかに結局エラーハンドリング多くなってめんどくさい
    ここに一週間ぐらい足止めくらった。
    ただ、個人開発で練習も兼ねている時はとにかく動くものを作ったほうが純粋に楽しいので、まずは動的割付でもいいか。と割り切って気になる部分は一旦置いて次に進むか。
     */
