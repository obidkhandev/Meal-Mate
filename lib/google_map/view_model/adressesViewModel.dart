import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../data/local/local_db.dart';
import '../../data/model/place_model.dart';

class AddressesViewModel2 extends ChangeNotifier {

  List<PlaceModel> myAddresses = [];
  bool _isLoading = false;
  bool get getLoader => _isLoading;

  Future<void> insertProducts(PlaceModel productModel) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection("places")
          .add(productModel.toJson());

      await FirebaseFirestore.instance
          .collection("places")
          .doc(cf.id)
          .update({"docId": cf.id});

      _notify(false);
    } on FirebaseException catch (error) {
      debugPrint(error.toString());
    }
  }

  Stream<List<PlaceModel>> listenProducts() => FirebaseFirestore.instance
      .collection("places")
      .snapshots()
      .map((event) {
    List<PlaceModel> foodList = event.docs.map((doc) => PlaceModel.fromJson(doc.data())).toList();
    return foodList;
  });

  Future<void> updatePlace(PlaceModel placeModel) async {
    _notify(true);
    await LocalDatabase.updatePlace(placeModel);
    _notify(false);
  }

  Future<void> deleteAddress() async {
    _notify(true);
    await LocalDatabase.deleteAllProducts();
    _notify(false);
  }

  // Additional Firebase methods

  Future<void> deletePlace(String placeId) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection("places")
          .doc(placeId)
          .delete();
      _notify(false);
    } on FirebaseException catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> updatePlaceWithId(String placeId, PlaceModel updatedPlace) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection("places")
          .doc(placeId)
          .update(updatedPlace.toJson());
      _notify(false);
    } on FirebaseException catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> deleteAllPlaces() async {
    try {
      // Get a reference to the "places" collection
      CollectionReference placesRef =
      FirebaseFirestore.instance.collection("places");

      // Get all documents in the "places" collection
      QuerySnapshot snapshot = await placesRef.get();

      // Loop through all documents and delete them
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (error) {
      // Handle any errors that occur during deletion
      print("Error deleting all places: $error");
      throw error; // You can choose to re-throw the error or handle it accordingly
    }
  }

  // Helper method to notify listeners
  void _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
