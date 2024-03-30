import 'package:flutter/foundation.dart';

import '../data/local/local_database.dart';
import '../data/models/place_model.dart';

class AddressesViewModel extends ChangeNotifier {
  AddressesViewModel() {
    get();
  }

  get() async {
    myAddresses = await LocalDatabase.getAllItems();
  }

  List<PlaceModel> myAddresses = [];

  final bool _isLoading = false;

  bool get getLoader => _isLoading;

  addNewAddress(PlaceModel placeModel) async {
    myAddresses.add(placeModel);

    notifyListeners();
    //Save some place
  }

  deleteAddress(PlaceModel placeModel) {
    myAddresses.remove(placeModel);
    notifyListeners();
  }
}
