import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SingInViewModel extends ChangeNotifier{


  User? user;

  bool checkCurrentUser() => FirebaseAuth.instance.currentUser != null;

  Future<void> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> logOut() async{
    await FirebaseAuth.instance.signOut();
  }

}