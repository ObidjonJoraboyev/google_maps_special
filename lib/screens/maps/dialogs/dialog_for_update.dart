import 'package:flutter/material.dart';
import 'package:google_maps_special/screens/maps/dialogs/addressDetailDialog.dart';
import '../../../data/local/local_database.dart';
import '../../../data/models/place_category.dart';
import '../../../data/models/place_model.dart';

PlaceModel addressDetailDialogForUpdate(
    {required PlaceModel placeModelInitial,
    required BuildContext context,
    required ValueChanged<PlaceModel> placeModel,
    required String defaultName}) {
  TextEditingController nameController = TextEditingController();
  TextEditingController flatNumber = TextEditingController();
  TextEditingController orient = TextEditingController();
  TextEditingController entrance = TextEditingController();
  TextEditingController stage = TextEditingController();

  nameController.text = placeModelInitial.placeName;
  flatNumber.text = placeModelInitial.flatNumber;
  orient.text = placeModelInitial.orientAddress;
  entrance.text = placeModelInitial.entrance;
  stage.text = placeModelInitial.stage;

  nameController.text = defaultName;
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Update Address",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black.withOpacity(.4)),
                    labelText: "Name",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(.5),
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(.5),
                        )),
                  ),
                  controller: nameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.black.withOpacity(.4)),
                          labelText: "Entrance",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black.withOpacity(.5),
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black.withOpacity(.5),
                              )),
                        ),
                        controller: entrance,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.black.withOpacity(.4)),
                          labelText: "Stage",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black.withOpacity(.5),
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black.withOpacity(.5),
                              )),
                        ),
                        controller: stage,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.black.withOpacity(.4)),
                          labelText: "Apartment",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black.withOpacity(.5),
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black.withOpacity(.5),
                              )),
                        ),
                        controller: flatNumber,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black.withOpacity(.4)),
                    labelText: "Orient",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(.5),
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(.5),
                        )),
                  ),
                  controller: orient,
                ),
              ),
              const SizedBox(height: 4),
              TextButton(
                  onPressed: () {
                    placeModel.call(
                      PlaceModel(
                        entrance: entrance.text,
                        flatNumber: flatNumber.text,
                        orientAddress: orient.text,
                        placeCategory: PlaceCategory.home,
                        lat: 0,
                        long: 0,
                        placeName: nameController.text,
                        stage: stage.text,
                      ),
                    );

                    LocalDatabase.updatePlace(PlaceModel(
                        placeCategory: PlaceCategory.home,
                        placeName: defaultName,
                        entrance: entrance.text,
                        flatNumber: flatNumber.text,
                        orientAddress: orient.text,
                        stage: stage.text,
                        id: placeModelInitial.id,
                        lat: placeModelInitial.lat,
                        long: placeModelInitial.long));


                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 18),
                  )),
              const SizedBox(height: 24),
            ],
          ),
        );
      });

  return PlaceModel(
      placeCategory: PlaceCategory.home,
      placeName: defaultName,
      entrance: entrance.text,
      flatNumber: flatNumber.text,
      orientAddress: orient.text,
      stage: stage.text,
      id: placeModelInitial.id,
      lat: placeModelInitial.lat,
      long: placeModelInitial.long);
}
