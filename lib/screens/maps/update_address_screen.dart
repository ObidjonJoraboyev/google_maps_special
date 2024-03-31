import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_special/screens/maps/dialogs/dialog_for_update.dart';
import 'package:provider/provider.dart';

import '../../data/models/place_category.dart';
import '../../data/models/place_model.dart';
import '../../utils/images/app_images.dart';
import '../../utils/styles/app_text_style.dart';
import '../../view_models/addresses_view_model.dart';
import '../../view_models/maps_view_model.dart';
import '../widgets/map_type_item.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({
    super.key,
    required this.placeModel,
    required this.index,
  });

  final int index;
  final PlaceModel placeModel;

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  int activeIndex = 0;

  @override
  void initState() {
    activeIndex = getNumber(widget.placeModel.placeCategory);
    super.initState();
  }

  int getNumber(PlaceCategory placeCategory) {
    switch (placeCategory) {
      case PlaceCategory.work:
        return 2;
      case PlaceCategory.home:
        return 1;
      case PlaceCategory.other:
        return 3;
      default:
        return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition? cameraPosition;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update"),
        toolbarHeight: 70,
        actions: [
          SizedBox(
            width: 90,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 16),
                )),
          )
        ],
      ),
      body: Consumer<MapsViewModel>(
        builder: (context, viewModel, child) {
          return Stack(
            children: [
              GoogleMap(
                markers: viewModel.markers,
                onCameraIdle: () {
                  if (cameraPosition != null) {
                    context
                        .read<MapsViewModel>()
                        .changeCurrentLocation(cameraPosition!);
                  }
                },
                onCameraMove: (CameraPosition currentCameraPosition) {
                  cameraPosition = currentCameraPosition;
                },
                mapType: viewModel.mapType,
                initialCameraPosition: viewModel.initialCameraPosition ??
                    const CameraPosition(target: LatLng(0, 0)),
                onMapCreated: (GoogleMapController createdController) {
                  viewModel.controller.complete(createdController);
                },
              ),
              Align(
                child: Image.asset(
                  AppImages.location,
                  width: 50,
                  height: 50,
                ),
              ),
              Positioned(
                top: 40,
                right: 0,
                left: 0,
                child: Text(
                  viewModel.currentPlaceName,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.interSemiBold.copyWith(
                      fontSize: 24,
                      color: Colors.white,
                      shadows: [
                        const Shadow(color: Colors.black, blurRadius: 40)
                      ]),
                ),
              ),
              Positioned(
                bottom: 30,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 13),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 7),
                                  color: Colors.black.withOpacity(.24))
                            ],
                            borderRadius: BorderRadius.circular(16),
                            color: activeIndex == 1
                                ? Colors.orangeAccent
                                : Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              activeIndex = 1;
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.home,
                                  color: activeIndex != 1
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: activeIndex != 1
                                          ? Colors.black
                                          : Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 13),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 7),
                                  color: Colors.black.withOpacity(.24))
                            ],
                            borderRadius: BorderRadius.circular(16),
                            color: activeIndex == 2
                                ? Colors.orangeAccent
                                : Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              activeIndex = 2;
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.work,
                                  color: activeIndex != 2
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                Text(
                                  "Work",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: activeIndex != 2
                                          ? Colors.black
                                          : Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 13),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 7),
                                  color: Colors.black.withOpacity(.24))
                            ],
                            borderRadius: BorderRadius.circular(16),
                            color: activeIndex == 3
                                ? Colors.orangeAccent
                                : Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              activeIndex = 3;
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit_location_alt,
                                  color: activeIndex != 3
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                Text(
                                  "Other",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: activeIndex != 3
                                          ? Colors.black
                                          : Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(top: 15, left: 80, right: 80),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 13),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 7),
                              color: Colors.black.withOpacity(.24))
                        ],
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.orangeAccent,
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            addressDetailDialogForUpdate(
                              placeModelInitial: widget.placeModel,
                              context: context,
                              placeModel: (newAddressDetails) {
                                PlaceModel place = newAddressDetails;
                                place.lat =
                                    cameraPosition?.target.latitude ?? 12;
                                place.long =
                                    cameraPosition?.target.longitude ?? 12;
                                place.placeCategory = activeIndex == 1
                                    ? PlaceCategory.home
                                    : activeIndex == 2
                                        ? PlaceCategory.work
                                        : PlaceCategory.other;
                                context
                                    .read<AddressesViewModel>()
                                    .updateAddress(
                                        placeModel: place, index: widget.index!=0?widget.index:1);
                                Navigator.pop(context);
                              },
                              defaultName: activeIndex == 1
                                  ? "Home"
                                  : activeIndex == 2
                                      ? "Work"
                                      : "Other",
                            );
                          },
                          child: Text(
                            "Update as ${activeIndex == 1 ? "Home" : activeIndex == 2 ? "Work" : "Other"}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 340,
                right: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        context.read<MapsViewModel>().moveToInitialPosition();
                      },
                      child: const Icon(Icons.gps_fixed),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    const MapTypeItem(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
