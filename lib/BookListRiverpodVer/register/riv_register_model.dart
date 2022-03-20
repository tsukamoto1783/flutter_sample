import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final register_Provider = ChangeNotifierProvider<RegisterModel>(
  (ref) => RegisterModel(),
);

class RegisterModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passswordController = TextEditingController();

  String? email;
  String? passsword;
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
    this.passsword = passsword;
    notifyListeners();
  }

  //New Registration
  Future signUp() async {
    email = emailController.text;
    passsword = passswordController.text;
    if (email != null && passsword != null) {
      // New registration for FirebaseAuth
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: passsword!,
      );
      final user = userCredential.user;

      // Add registration information to Firestore
      if (user != null) {
        final uid = user.uid;
        final doc = FirebaseFirestore.instance.collection('users').doc(uid);
        await doc.set({
          'uid': uid,
          'email': email,
        });
      }
    }
  }
}
