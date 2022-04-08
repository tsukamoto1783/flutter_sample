// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class EditProfilePage extends StatelessWidget {
//   EditProfilePage(this.name, this.description);
//   String? name;
//   String? description;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('プロフィールを編集'),
//         ),
//         body: Center(child: edit_profile_body(name, description)));
//   }
// }
//
// class edit_profile_body extends ConsumerWidget {
//   edit_profile_body(this.name, this.description);
//   String? name;
//   String? description;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Providerに複数の引数を渡す場合は、freezeパッケージとかと組み合わせて使用する必要あり。今回は割愛する。。
//     final edit_profile_ins = ref.watch(edit_profile_Provider);
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           TextField(
//             controller: edit_profile_ins.nameController,
//             decoration: const InputDecoration(
//               hintText: '名前',
//             ),
//             onChanged: (text) {
//               edit_profile_ins.setName(text);
//             },
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           TextField(
//             controller: edit_profile_ins.descriptionController,
//             decoration: const InputDecoration(
//               hintText: '自己紹介',
//             ),
//             onChanged: (text) {
//               edit_profile_ins.setDescription(text);
//             },
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           ElevatedButton(
//             onPressed: edit_profile_ins.isUpdated()
//                 ? () async {
//                     try {
//                       await edit_profile_ins.update();
//                       Navigator.of(context).pop();
//                     } catch (e) {
//                       final snackBar = SnackBar(
//                         backgroundColor: Colors.red,
//                         content: Text(e.toString()),
//                       );
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                     }
//                   }
//                 : null,
//             child: const Text('更新する'),
//           ),
//         ],
//       ),
//     );
//   }
// }
