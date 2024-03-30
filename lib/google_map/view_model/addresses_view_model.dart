
import 'package:flutter/foundation.dart';

import '../../data/local/local_db.dart';
import '../../data/model/place_model.dart';

class AddressesViewModel extends ChangeNotifier {
  AddressesViewModel() {
    getAllPlace(); //Read Addresses from Local Database or Firebase
  }

  List<PlaceModel> myAddresses = [];
  bool _isLoading = false;
  bool get getLoader => _isLoading;

  addNewAddress(PlaceModel placeModel) async {
    _notify(true);
    LocalDatabase.insertPlace(placeModel);
    debugPrint("Add Succesfully");
    _notify(false);
  }

  getAllPlace() async{
    _notify(true);
    myAddresses = await LocalDatabase.getAllItems();
    _notify(false);
  }

  updatePlace(PlaceModel placeModel) async{
    _notify(true);
    await LocalDatabase.updatePlace(placeModel);
    getAllPlace();
    _notify(false);
  }
  deleteAddress(){}


  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
