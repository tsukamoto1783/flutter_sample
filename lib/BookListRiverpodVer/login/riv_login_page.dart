import 'package:flutter/material.dart';
import '../login/riv_login_model.dart';
import '../register/riv_register_page.dart';
import 'riv_login_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: login_body(),
      ),
    );
  }
}

class login_body extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final login_ins = ref.watch(login_Provider);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Email address input form
              TextField(
                controller: login_ins.emailController,
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                ),
                onChanged: (text) {
                  login_ins.setEmail(text);
                },
              ),
              const SizedBox(
                height: 8,
              ),

              // Password input form
              TextField(
                controller: login_ins.passswordController,
                decoration: const InputDecoration(
                  hintText: 'PassWord',
                ),
                onChanged: (text) {
                  login_ins.setPasssword(text);
                },
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),

              // Login button
              ElevatedButton(
                onPressed: () async {
                  login_ins.startLoding();
                  try {
                    await login_ins.login();
                    Navigator.of(context).pop();
                  } catch (e) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } finally {
                    login_ins.endLoding();
                  }
                },
                child: const Text('Login'),
              ),

              // Screen transition to RegisterPage
              TextButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                        fullscreenDialog: true),
                  );
                },
                child: const Text('新規登録'),
              ),
            ],
          ),
        ),

        // Loading Process
        if (login_ins.isLoading)
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
