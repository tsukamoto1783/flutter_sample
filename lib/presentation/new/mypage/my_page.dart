import 'package:flutter/material.dart';
import 'package:flutter_practice/presentation/new/edit_profile/edit_profile_page.dart';
import 'package:provider/provider.dart';

import 'my_model.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (_) => MyModel()..fetchUser(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          actions: [
            Consumer<MyModel>(builder: (context, model, child) {
              return IconButton(
                //Screen transition to loginPage
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditProfilePage(model.name, model.description),
                    ),
                  );
                  model.fetchUser();
                },
                icon: const Icon(Icons.edit),
              );
            }),
          ],
        ),
        body: Center(
          child: Consumer<MyModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        model.name ?? '名前未登録',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(model.email ?? "メールアドレス未登録"),
                      Text(model.description ?? "自己紹介未登録"),

                      //LogOut
                      TextButton(
                        onPressed: () async {
                          await model.logout();
                          Navigator.of(context).pop();
                        },
                        child: const Text('ログアウト'),
                      )
                    ],
                  ),
                ),
                // ↓Loading animation
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
