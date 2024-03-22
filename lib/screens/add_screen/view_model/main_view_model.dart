import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

class ProductsViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get getLoader => _isLoading;
  List<FoodModel> categoryProduct = [];
  List<FoodModel> ownProducts = [];

  Stream<List<FoodModel>> listenProducts() => FirebaseFirestore.instance
      .collection(AppConstants.foodDBTable)
      .snapshots()
      .map(
        (event) =>
        event.docs.map((doc) => FoodModel.fromJson(doc.data())).toList(),
  );

  Future<void> getProductsByEmail(String email) async {
    _notify(true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(AppConstants.foodDBTable)
          .where("userEmail", isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        ownProducts =
            snapshot.docs.map((e) => FoodModel.fromJson(e.data())).toList();
        debugPrint(ownProducts.first.userName);
      } else {
        debugPrint("No products found for the user with email: $email");
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
      // Handle the error gracefully, for example:
      // Show a snackbar or display an error message to the user
    } finally {
      _notify(false);
    }
  }

  Stream<List<FoodModel>> getProductsByEmailStream(String email) {
    return FirebaseFirestore.instance
        .collection(AppConstants.foodDBTable)
        .where("userEmail", isEqualTo: email)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => FoodModel.fromJson(doc.data()))
        .toList());
  }

  insertProducts(FoodModel productModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection(AppConstants.foodDBTable)
          .add(productModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.foodDBTable)
          .doc(cf.id)
          .update({"docId": cf.id});

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      myAnimatedSnackBar(
       context,error.code,
      );
    }
  }

  updateProduct(FoodModel productModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.foodDBTable)
          .doc(productModel.docId)
          .update(productModel.toJsonForUpdate());

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      myAnimatedSnackBar(
       context,error.code,
      );
    }
  }

  deleteProduct(String docId, BuildContext context) async {
    try {
      // _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.foodDBTable)
          .doc(docId)
          .delete();


      // _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      myAnimatedSnackBar(
      context,error.code,
      );
    }
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}