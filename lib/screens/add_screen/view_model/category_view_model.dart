import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_mate/data/model/category_model.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

class CategoryViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get getLoader => _isLoading;
  String categoryId= '';

  Stream<List<CategoryModel>> listenProducts() => FirebaseFirestore.instance
      .collection(AppConstants.category)
      .snapshots()
      .map(
        (event) =>
        event.docs.map((doc) => CategoryModel.fromJson(doc.data())).toList(),
  );

  insertCategory(CategoryModel productModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection(AppConstants.category)
          .add(productModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.category)
          .doc(cf.id)
          .update({"categoryId": cf.id});
      categoryId = cf.id;
      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      myAnimatedSnackBar(
        context,error.code,
      );
    }
  }

  updateCategory(CategoryModel productModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.category)
          .doc(productModel.categoryId)
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
          .collection(AppConstants.category)
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