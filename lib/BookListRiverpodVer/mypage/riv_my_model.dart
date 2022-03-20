import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final my_page_Provider = ChangeNotifierProvider<MyModel>(
  (ref) => MyModel(),
);

class MyModel extends ChangeNotifier {
  bool isLoading = false;
  String? name;
  String? description;
  String? email;

  // Loading function
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  //Update display data
  Future fetchUser() async {
    //Get UserID from FirebaseAuth
    final user = FirebaseAuth.instance.currentUser;
    email = user?.email;

    //Get information associated with UserID from Firestore
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    final data = snapshot.data();

    name = data?['name'];
    description = data?['description'];

    notifyListeners();
  }

  //SignOut
  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
