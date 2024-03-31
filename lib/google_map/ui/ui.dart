import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meal_mate/data/model/place_category.dart';
import 'package:meal_mate/google_map/view_model/location_view_model.dart';
import 'package:meal_mate/google_map/widget/dialogs.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';
import '../../data/model/place_model.dart';
import '../view_model/addresses_view_model.dart';
import '../view_model/adressesViewModel.dart';
import '../view_model/map_view_model.dart';
import '../widget/my_tab_item.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({Key? key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  int buttonActiveIndex = 0;

  @override
  Widget build(BuildContext context) {

    CameraPosition? cameraPosition;
    return Scaffold(
      body: Consumer<MapsViewModel>(
        builder: (context, viewModel, child) {
          return Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
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
                bottom: 15,
                left: 0,
                right: 0,
                top: height(context) * 0.78,
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
                          placeCategory: PlaceCategory.values[buttonActiveIndex].name,
                          lat: cameraPosition!.target.latitude ,
                          long: cameraPosition!.target.longitude,
                          currentPlaceName: viewModel.currentPlaceName,
                          titleName: 'Add Location',
                          context: context,
                          placeModel: (newAddressDetails) {
                            PlaceModel place = newAddressDetails.copyWith(
                              placeName: viewModel.currentPlaceName,
                              placeCategory: PlaceCategory.values[buttonActiveIndex].name,
                            );
                            context.read<AddressesViewModel2>().insertProducts(place);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Place added successfully',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: AppColors.primary,
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Save Location",
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

class MyElevatedButton extends StatelessWidget {
  final Function() onTap;
  final String name;
  final IconData iconData;
  final Color backgroundColor;
  final Color mainColor;

  const MyElevatedButton({
    Key? key,
    required this.onTap,
    required this.name,
    required this.iconData,
    required this.backgroundColor,
    required this.mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shadowColor: Colors.grey,
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              iconData,
              color: mainColor,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 16, color: mainColor),
            ),
          ],
        ),
      ),
    );
  }
}
