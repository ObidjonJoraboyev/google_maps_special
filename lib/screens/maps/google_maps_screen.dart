import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../data/models/place_category.dart';
import '../../data/models/place_model.dart';
import '../../utils/images/app_images.dart';
import '../../utils/styles/app_text_style.dart';
import '../../view_models/addresses_view_model.dart';
import '../../view_models/maps_view_model.dart';
import '../addresses/addresses_screen.dart';
import '../widgets/map_type_item.dart';
import 'dialogs/addressDetailDialog.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({
    super.key,
  });

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  int activeIndex = 1;

  @override
  Widget build(BuildContext context) {
    CameraPosition? cameraPosition;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google maps"),
        toolbarHeight: 70,
        actions: [
          SizedBox(
            width: 90,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressesScreen()));
                },
                icon: const Row(
                  children: [
                    Text("Saves  "),
                    Icon(
                      Icons.arrow_right_alt,
                      size: 22,
                    ),
                  ],
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
                initialCameraPosition: viewModel.initialCameraPosition??CameraPosition(target: LatLng(12,12)),
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
                child: Column(
                  children: [
                    Text(
                      viewModel.currentPlaceName,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.interSemiBold.copyWith(
                          fontSize: 24,
                          color: Colors.white,
                          shadows: [
                            const Shadow(color: Colors.black, blurRadius: 40)
                          ]),
                    ),



                    Text("${viewModel.currentCameraPosition.target.latitude}",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600),)
                  ],
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
                      margin: const EdgeInsets.only(top: 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 13),
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
                      child: InkWell(
                        onTap: () {
                          addressDetailDialog(
                            context: context,
                            placeModel: (newAddressDetails) {
                              PlaceModel place = newAddressDetails;
                              place.lat = cameraPosition?.target.latitude ?? 12;
                              place.long =
                                  cameraPosition?.target.longitude ?? 12;
                              place.placeCategory = activeIndex == 1
                                  ? PlaceCategory.home
                                  : activeIndex == 2
                                      ? PlaceCategory.work
                                      : PlaceCategory.other;
                              context
                                  .read<AddressesViewModel>()
                                  .addNewAddress(place);
                              Navigator.pop(context);
                            },
                            defaultName: viewModel.currentPlaceName,
                          );
                        },
                        child: Text(
                          "Add as ${activeIndex == 1 ? "Home" : activeIndex == 2 ? "Work" : "Other"}",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
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
