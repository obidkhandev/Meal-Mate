import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

class ProductsViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get getLoader => _isLoading;
  FoodModel? foodModel;
  FoodModel get getFood => foodModel!;
  List<FoodModel> ownProducts = [];


  Future<void> getProductFromId(String productId) async {
    // Notify listeners that fetching is in progress
    _notify(true);

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection(AppConstants.foodDBTable).doc(productId).get();

      // Check if the document exists
      if (snapshot.exists) {
        // Convert the snapshot data to a FoodModel object
        foodModel =  FoodModel.fromJson(snapshot.data()!);
        _notify(false);
      } else {
        // Notify listeners that fetching is completed (even if not successful)
        _notify(false);

        // Handle the case when the document does not exist
        debugPrint("Document with ID $productId does not exist.");
        return null; // Return null to indicate that no product was found
      }
    } catch (error) {
      // Notify listeners that fetching is completed (even if not successful)
      _notify(false);

      // Handle any errors that occur during fetching
      debugPrint('Error fetching product: $error');
      return null; // Return null in case of an error
    }
  }




  Stream<List<FoodModel>> listenProducts() => FirebaseFirestore.instance
      .collection(AppConstants.foodDBTable)
      .snapshots()
      .map((event) {
    List<FoodModel> foodList = event.docs.map((doc) => FoodModel.fromJson(doc.data())).toList();

    foodList.sort((a, b) => b.timestamp.compareTo(a.timestamp)); // Sort in descending order

    return foodList;
  });


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