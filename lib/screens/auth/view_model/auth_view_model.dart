import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../data/model/user_model.dart';
import '../../../utils/tools/file_importer.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get loading => _isLoading;

  User? get getUser => FirebaseAuth.instance.currentUser;

  registerUser(
    BuildContext context, {
    required String email,
    required String password,
    required String username,
  }) async {
    if (AppValidates.emailExp.hasMatch(email) &&
        AppValidates.passwordExp.hasMatch(password)) {
      try {
        _notify(true);
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
        }
        _addNewUserToList(userCredential);
        _notify(false);
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, RouteName.tabBox);
      } on FirebaseAuthException catch (e) {
        if (!context.mounted) return;
        showErrorForRegister(e.code, context);
      } catch (error) {
        if (!context.mounted) return;
        myAnimatedSnackBar(
          context,
          "Noma'lum xatolik yuz berdi:$error.",
        );
      }
    } else {
      myAnimatedSnackBar(
        context,
        "Login yoki Parolni xato kiritdingiz!",
      );
    }
  }

  loginUser(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    if (AppValidates.emailExp.hasMatch(email) &&
        AppValidates.passwordExp.hasMatch(password)) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, RouteName.tabBox);
      } on FirebaseAuthException catch (err) {
        if (!context.mounted) return;
        showErrorForLogin(err.code, context);
      } catch (error) {
        if (!context.mounted) return;
        myAnimatedSnackBar(
          context,
          "Noma'lum xatolik yuz berdi:$error.",
        );
      }
    } else {
      myAnimatedSnackBar(
        context,
        "Login yoki Parolni xato kiritdingiz!",
      );
    }
  }


  List<UserModel>? usersModel;

  List<UserModel>? get users => usersModel;
  bool load = false;
  bool get isLoad => load;

  Future<void> getData() async {
    load = true;
    notifyListeners();
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('all_users');

    try {
      // Get docs from collection reference
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _collectionRef.get() as QuerySnapshot<Map<String, dynamic>>;

      // Get data from docs and convert map to List<UserModel>
      usersModel = querySnapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      load = false;
      notifyListeners();
    } catch (e) {
      print("Error getting data: $e");
    }
  }


  _addNewUserToList(UserCredential userCredential) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    var user = await FirebaseFirestore.instance.collection("all_users").add({
      "user_id": userCredential.user != null ? userCredential.user!.uid : "",
      "user_name":
          userCredential.user != null ? userCredential.user!.displayName : "",
      "e_mail": userCredential.user != null ? userCredential.user!.email : "",
      "image_url":
          userCredential.user != null ? userCredential.user!.photoURL : "",
      "fcm_token": fcmToken ?? "",
      "user_doc_id": "",
    });
    await FirebaseFirestore.instance
        .collection("all_users")
        .doc(user.id)
        .update({"user_doc_id": user.id});
  }

  logout(BuildContext context) async {
    _notify(true);
    await FirebaseAuth.instance.signOut();
    _notify(false);
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, RouteName.signIn);
  }

  updateUsername(String username) async {
    _notify(true);
    await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
    _notify(false);
  }

  updateImageUrl(String imagePath) async {
    _notify(true);
    try {
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imagePath);
    } catch (error) {
      debugPrint("ERROR:$error");
    }
    _notify(false);
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
