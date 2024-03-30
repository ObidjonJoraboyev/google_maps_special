import 'package:flutter/material.dart';
import 'package:flutter_nt_ten/data/models/place_category.dart';
import 'package:flutter_nt_ten/data/models/place_model.dart';
import 'package:flutter_nt_ten/screens/maps/dialogs/addressDetailDialog.dart';
import 'package:flutter_nt_ten/screens/widgets/map_type_item.dart';
import 'package:flutter_nt_ten/utils/images/app_images.dart';
import 'package:flutter_nt_ten/utils/styles/app_text_style.dart';
import 'package:flutter_nt_ten/view_models/addresses_view_model.dart';
import 'package:flutter_nt_ten/view_models/maps_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({
    super.key,
    required this.placeModel,
  });

  final PlaceModel placeModel;

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  @override
  void initState() {
    context.read<MapsViewModel>().currentPlaceName =
        widget.placeModel.placeName;

    context.read<MapsViewModel>().setLatInitialLong(LatLng(widget.placeModel.lat, widget.placeModel.long));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition? cameraPosition;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
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
                initialCameraPosition: viewModel.initialCameraPosition,
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
                top: 100,
                right: 0,
                left: 0,
                child: Text(
                  viewModel.currentPlaceName,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 24,
                  ),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<MapsViewModel>().moveToInitialPosition();
            },
            child: const Icon(Icons.gps_fixed),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () {
              addressDetailDialog(
                context: context,
                placeModel: (newAddressDetails) {
                  PlaceModel place = newAddressDetails;
                  place.lat = cameraPosition!.target.latitude;
                  place.placeCategory = PlaceCategory.work;
                  context.read<AddressesViewModel>().addNewAddress(place);
                  Navigator.pop(context);
                }, defaultName: '',
              );
            },
            child: const Icon(Icons.place),
          ),
          const SizedBox(width: 20),
          const MapTypeItem(),
        ],
      ),
    );
  }
}
