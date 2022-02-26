import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../register/regster_page.dart';
import 'login_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: Consumer<LoginModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Email address input form
                      TextField(
                        controller: model.emailController,
                        decoration: const InputDecoration(
                          hintText: 'E-mail',
                        ),
                        onChanged: (text) {
                          model.setEmail(text);
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      // Password input form
                      TextField(
                        controller: model.passswordController,
                        decoration: const InputDecoration(
                          hintText: 'PassWord',
                        ),
                        onChanged: (text) {
                          model.setPasssword(text);
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      // Login button
                      ElevatedButton(
                        onPressed: () async {
                          model.startLoding();
                          try {
                            await model.login();
                            Navigator.of(context).pop();
                          } catch (e) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(e.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } finally {
                            model.endLoding();
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
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              ],
            );
          }),
        ),
      ),
    );
  }
}
