import 'package:flutter/material.dart';
import 'package:flutter_practice/presentation/new/edit_profile/edit_profile_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'riv_my_model.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          Consumer(builder: (context, ref, _) {
            final my_profile_ins = ref.watch(my_page_Provider);
            return IconButton(
              //Screen transition to loginPage
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                        my_profile_ins.name, my_profile_ins.description),
                  ),
                );
                my_profile_ins.fetchUser();
              },
              icon: const Icon(Icons.edit),
            );
          }),
        ],
      ),
      body: Center(
        child: my_page_body(),
      ),
    );
  }
}

class my_page_body extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final my_page_ins = ref.watch(my_page_Provider);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                my_page_ins.name ?? '名前未登録',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(my_page_ins.email ?? "メールアドレス未登録"),
              Text(my_page_ins.description ?? "自己紹介未登録"),

              //LogOut
              TextButton(
                onPressed: () async {
                  await my_page_ins.logout();
                  Navigator.of(context).pop();
                },
                child: const Text('ログアウト'),
              )
            ],
          ),
        ),

        // ↓Loading animation
        if (my_page_ins.isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
