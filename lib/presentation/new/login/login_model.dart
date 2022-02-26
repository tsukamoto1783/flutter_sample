import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passswordController = TextEditingController();

  String? email;
  String? password;
  bool isLoading = false;

  // Loading function
  void startLoding() {
    isLoading = true;
    notifyListeners();
  }

  void endLoding() {
    isLoading = false;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPasssword(String passsword) {
    password = passsword;
    notifyListeners();
  }

  Future login() async {
    email = emailController.text;
    password = passswordController.text;

    //login
    if (email != null && password != null) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
    }
  }
}
