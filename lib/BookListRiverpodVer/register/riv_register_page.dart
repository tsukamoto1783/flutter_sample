import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'riv_register_model.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
      ),
      body: Center(
        child: register_body(),
      ),
    );
  }
}

class register_body extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final register_ins = ref.watch(register_Provider);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Email address input form
              TextField(
                controller: register_ins.emailController,
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                ),
                onChanged: (text) {
                  register_ins.setEmail(text);
                },
              ),
              const SizedBox(
                height: 8,
              ),

              // Password input form
              TextField(
                controller: register_ins.passswordController,
                decoration: const InputDecoration(
                  hintText: 'password',
                ),
                onChanged: (text) {
                  register_ins.setPasssword(text);
                },
              ),
              const SizedBox(
                height: 16,
              ),

              // Login button
              ElevatedButton(
                onPressed: () async {
                  register_ins.startLoding();

                  // 追加の処理
                  try {
                    await register_ins.signUp();
                    Navigator.of(context).pop();
                  } catch (e) {
                    print(e);
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } finally {
                    register_ins.endLoding();
                  }
                },
                child: const Text('新規登録する'),
              ),
            ],
          ),
        ),
        if (register_ins.isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
