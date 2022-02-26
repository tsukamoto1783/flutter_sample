import 'package:flutter/material.dart';
import 'package:flutter_practice/presentation/new/register/register_model.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('新規登録'),
        ),
        body: Center(
          child: Consumer<RegisterModel>(builder: (context, model, child) {
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
                          hintText: 'password',
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

                          // 追加の処理
                          try {
                            await model.signUp();
                            Navigator.of(context).pop();
                          } catch (e) {
                            print(e);
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
                        child: const Text('新規登録する'),
                      ),
                    ],
                  ),
                ),
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
