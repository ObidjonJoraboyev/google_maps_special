import 'package:flutter/material.dart';

import '../../../data/models/place_model.dart';
addressDetailDialog({
  required BuildContext context,
  required ValueChanged<PlaceModel> placeModel,
  required String defaultName
}) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController flatNumber = TextEditingController();
  final TextEditingController orient = TextEditingController();
  final TextEditingController entrance = TextEditingController();
  final TextEditingController stage = TextEditingController();
  nameController.text=defaultName;
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
                "Add Address",
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

                    LocalDatabase.insertPlace(   PlaceModel(
                      entrance: entrance.text,
                      flatNumber: flatNumber.text,
                      orientAddress: orient.text,
                      placeCategory: PlaceCategory.home,
                      lat: 0,
                      long: 0,
                      placeName: nameController.text,
                      stage: stage.text,
                    ),);
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return AddressesScreen();
                    }));
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
}