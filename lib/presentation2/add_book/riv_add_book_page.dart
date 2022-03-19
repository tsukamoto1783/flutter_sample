import 'package:flutter/material.dart';

class AddBookPage extends StatelessWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本を追加'),
      ),
      body: Center(
          // child: Consumer<AddBookModel>(builder: (context, model, child) {
          //   return Stack(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Column(
          //           children: [
          //             // ↓Image Registration Form
          //             GestureDetector(
          //               child: SizedBox(
          //                 width: 100,
          //                 height: 160,
          //                 child: model.imageFile != null
          //                     ? Image.file(model.imageFile!)
          //                     : Container(
          //                         color: Colors.grey,
          //                       ),
          //               ),
          //               onTap: () async {
          //                 await model.pickImage();
          //               },
          //             ),
          //
          //             // ↓Title Registration Form
          //             TextField(
          //               decoration: const InputDecoration(
          //                 hintText: '本のタイトル',
          //               ),
          //               onChanged: (text) {
          //                 model.title = text;
          //               },
          //             ),
          //             const SizedBox(
          //               height: 8,
          //             ),
          //
          //             // ↓Author Registration Form
          //             TextField(
          //               decoration: const InputDecoration(
          //                 hintText: '本の著者',
          //               ),
          //               onChanged: (text) {
          //                 model.author = text;
          //               },
          //             ),
          //             const SizedBox(
          //               height: 16,
          //             ),
          //
          //             // ↓Add button processing
          //             ElevatedButton(
          //               onPressed: () async {
          //                 try {
          //                   model.startLoading();
          //                   await model.addBook();
          //                   Navigator.of(context).pop(true);
          //                 } catch (e) {
          //                   print(e);
          //                   final snackBar = SnackBar(
          //                     backgroundColor: Colors.red,
          //                     content: Text(e.toString()),
          //                   );
          //                   ScaffoldMessenger.of(context)
          //                       .showSnackBar(snackBar);
          //                 } finally {
          //                   model.endLoading();
          //                 }
          //               },
          //               child: const Text('追加する'),
          //             ),
          //           ],
          //         ),
          //       ),
          //
          //       // ↓Loading animation
          //       if (model.isLoading)
          //         Container(
          //           color: Colors.black54,
          //           child: const Center(
          //             child: CircularProgressIndicator(),
          //           ),
          //         ),
          //     ],
          //   );
          // }),
          ),
    );
  }
}
