import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

class ProductsViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get getLoader => _isLoading;
  List<FoodModel> categoryProduct = [];

  Stream<List<FoodModel>> listenProducts() => FirebaseFirestore.instance
      .collection(AppConstants.foodDBTable)
      .snapshots()
      .map(
        (event) =>
        event.docs.map((doc) => FoodModel.fromJson(doc.data())).toList(),
  );

  Future<void> getProductsByCategory(String categoryDocId) async {
    _notify(true);
    await FirebaseFirestore.instance
        .collection(AppConstants.foodDBTable)
        .where("category_id", isEqualTo: categoryDocId)
        .get()
        .then((snapshot) {
      categoryProduct =
          snapshot.docs.map((e) => FoodModel.fromJson(e.data())).toList();
    });
    _notify(false);
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
          .update({"doc_id": cf.id});

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
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.foodDBTable)
          .doc(docId)
          .delete();

      _notify(false);
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