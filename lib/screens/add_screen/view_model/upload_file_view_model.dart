import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageViewModel extends ChangeNotifier {
  bool _isLoading = false;


  String imageUrl = "";
  String storagePath = "";
  ImagePicker picker = ImagePicker();

  bool get getLoader => _isLoading;
  String get getImageUrl => imageUrl;
  String get getStoragePath=>storagePath;


  Future<void> getImageFromCamera(BuildContext context) async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await uploadImage(
        pickedFile: image,
        storagePath: storagePath,
      );
      print("Hello World");
      // notifyListeners();
      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  Future<void> getImageFromGallery(BuildContext context) async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await uploadImage(
        pickedFile: image,
        storagePath: storagePath,
      );
      print("Hello World");
      // print(imageUrl);
      // notifyListeners();
      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }


  // static void deleteFireBaseStorageItem(String fileUrl){
  //
  //   String filePath = 'https://firebasestorage.googleapis.com/v0/b/dial-i-2345.appspot.com/o/default_images%2Fuser.png?alt=media&token=c2ccceec-8d24-42fe-b5c0-c987733ac8ae'
  //       .replaceAll(new
  //   RegExp(r'https://firebasestorage.googleapis.com/v0/b/dial-in-2345.appspot.com/o/'), '');
  //
  //   FirebaseStorage.instance.ref().child(filePath).delete().then((_) => print('Successfully deleted $filePath storage item' ));
  //
  // }


  Future<String> uploadAndGetImageUrl(File file, String filename) async {
    String imageUrl = '';

    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child(filename);

    debugPrint(mountainsRef.name);

    final mountainImagesRef = storageRef.child("images/$filename");
    try {
      _notify(true);
      await mountainsRef.putFile(file);
    } on FirebaseException catch (e) {
      debugPrint("ERROR:${e.message}");
    }
    imageUrl = await mountainImagesRef.getDownloadURL();
    _notify(false);
    return imageUrl;
  }

  Future<String> uploadImage({required XFile pickedFile, required String storagePath}) async {
    try {

      var ref = FirebaseStorage.instance.ref().child(storagePath);
      _notify(true);
      File file = File(pickedFile.path);
      var uploadTask = await ref.putFile(file);
      String downloadUrl = await uploadTask.ref.getDownloadURL();

      _notify(false);
      return downloadUrl;
    } on FirebaseException catch (error) {
      throw Exception();
    }
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
