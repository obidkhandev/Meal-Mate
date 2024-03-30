import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meal_mate/google_map/ui/ui.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';
import 'package:provider/provider.dart';

import '../../data/model/place_category.dart';
import '../../data/model/place_model.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/style/app_text_style.dart';
import '../../utils/tools/assistant.dart';
import '../view_model/addresses_view_model.dart';
import '../view_model/location_view_model.dart';
import '../view_model/map_view_model.dart';
import '../widget/dialogs.dart';
import '../widget/my_tab_item.dart';

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

    context.read<MapsViewModel>().setLatInitialLong(
        LatLng(widget.placeModel.lat, widget.placeModel.long));
    super.initState();
  }

  int buttonActiveIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.placeModel.placeName);
    CameraPosition? cameraPosition;
    return Scaffold(
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
                initialCameraPosition: viewModel.initialCameraPosition!,
                onMapCreated: (GoogleMapController createdController) {
                  viewModel.controller.complete(createdController);
                },
              ),
              Align(
                child: Image.asset(
                  "assets/icons/inital_map_icon.png",
                  width: 50,
                  height: 50,
                ),
              ),
              Positioned(
                top: 100,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      viewModel.currentPlaceName,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.recolateBold
                          .copyWith(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                top: height(context) * 0.8,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: PlaceCategory.values.length,
                        itemBuilder: (context, index) {
                          return MyElevatedButton(
                            onTap: () {
                              setState(() {
                                buttonActiveIndex = index;
                              });
                            },
                            name: PlaceCategory.values[index].name,
                            iconData: iconsCategory[index],
                            backgroundColor: buttonActiveIndex == index
                                ? AppColors.primary
                                : Colors.white,
                            mainColor: buttonActiveIndex == index
                                ? Colors.white
                                : Colors.black,
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addressDetailDialog(
                          context: context,
                          placeModel: (newAddressDetails) {
                            PlaceModel place = newAddressDetails;
                            place = place.copyWith(
                                placeCategory:  PlaceCategory.values[buttonActiveIndex].name,
                                orientAddress: place.orientAddress,
                                lat: cameraPosition == null
                                    ? place.lat
                                    : cameraPosition!.target.latitude,
                                long: cameraPosition == null
                                    ? place.long
                                    : cameraPosition!.target.longitude,
                                entrance: place.entrance,
                                stage: place.stage,
                                placeName: place.placeName,
                                flatNumber: place.flatNumber,
                                id: widget.placeModel.id);
                            context
                                .read<AddressesViewModel>()
                                .updatePlace(place);
                            Navigator.pop(context);
                          },
                          placeCategory: PlaceCategory.values[buttonActiveIndex].name,
                          lat: cameraPosition == null
                              ? context
                                  .read<LocationViewModel>()
                                  .latLng!
                                  .latitude
                              : cameraPosition!.target.latitude,
                          long: cameraPosition == null
                              ? context
                                  .read<LocationViewModel>()
                                  .latLng!
                                  .longitude
                              : cameraPosition!.target.longitude,
                          currentPlaceName:
                              context.read<MapsViewModel>().currentPlaceName,
                          titleName: 'Update Location',
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Update place successfully',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: AppColors.primary,
                        ));
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(right: 15, left: 15, top: 20),
                        height: 56,
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          "Update Location",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: height(context) / 2,
                child: FloatingActionButton(
                  onPressed: () {
                    context.read<MapsViewModel>().moveToInitialPosition();
                  },
                  child: const Icon(Icons.gps_fixed),
                ),
              ),
              Positioned(
                right: 0,
                top: height(context) / 2 + 66,
                child: const MapTypeItem(),
              ),
            ],
          );
        },
      ),
    );
  }
}

