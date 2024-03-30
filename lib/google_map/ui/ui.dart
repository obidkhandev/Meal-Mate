import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meal_mate/google_map/view_model/location_view_model.dart';
import 'package:meal_mate/google_map/widget/dialogs.dart';
import 'package:meal_mate/utils/tools/assistant.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';
import 'package:provider/provider.dart';
import '../../data/model/place_category.dart';
import '../../data/model/place_model.dart';
import '../view_model/addresses_view_model.dart';
import '../view_model/map_view_model.dart';
import '../widget/my_tab_item.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({
    super.key,
  });

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
                  debugPrint(
                      "CURRENT POSITION:${currentCameraPosition.target.longitude}");
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
                  child: Text(
                    viewModel.currentPlaceName,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.recolateMedium.copyWith(
                      fontSize: 24,
                      color: MapType.values[0] == MapType.normal ? Colors.black : Colors.white,
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
                                : Colors.white, mainColor: buttonActiveIndex == index? Colors.white : Colors.black,
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                            addressDetailDialog(
                                  context: context,
                                  placeModel: (newAddressDetails) {
                                    PlaceModel place = newAddressDetails;
                                    place = place.copyWith(
                                      placeName: context.read<MapsViewModel>().currentPlaceName,
                                        placeCategory: place.placeCategory,
                                        orientAddress: place.orientAddress.isEmpty? "ff" : place.orientAddress,
                                        long: place.long,
                                        lat: place.lat,
                                      entrance: place.entrance.isEmpty? "hech narsa" : place.entrance,
                                      flatNumber: place.flatNumber.isEmpty? 'hech narsa':place.flatNumber,
                                      stage: place.stage.isEmpty? 'hech narsa' : place.stage,

                                    );
                                    context.read<AddressesViewModel>().addNewAddress(place);
                                    context.read<AddressesViewModel>().getAllPlace();
                                    Navigator.pop(context);
                                  },
                                  placeCategory: PlaceCategory.values[buttonActiveIndex].name,
                                  lat: cameraPosition == null
                                      ? context.read<LocationViewModel>().latLng!.latitude
                                      : cameraPosition!.target.latitude,
                                  long: cameraPosition == null
                                      ? context.read<LocationViewModel>().latLng!.longitude
                                      : cameraPosition!.target.longitude,
                                  currentPlaceName:
                                      context.read<MapsViewModel>().currentPlaceName,
                                );
                                ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                                  content:  Text(
                                    'Add place successfully',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: AppColors.primary,
                                ));

                              
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 15,left: 15,top: 20),
                        height: 56,
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Text("Save Location",style: TextStyle(fontSize: 22,color: Colors.white),),
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
                top: height(context)/2 + 66,
                child:  MapTypeItem(),),
            ],
          );
        },
      ),

  // floatingActionButton:
      // floatingActionButton: Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {
      //         context.read<MapsViewModel>().moveToInitialPosition();
      //       },
      //       child: const Icon(Icons.gps_fixed),
      //     ),
      //     const SizedBox(width: 20),
      //     // FloatingActionButton(
      //     //   onPressed: () {
      //     
      //     //   child: const Icon(Icons.place),
      //     // ),
      //     const SizedBox(width: 20),
      //     const
      //   ],
      // ),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  final Function() onTap;
  final String name;
  final IconData iconData;
  final Color backgroundColor;
  final Color mainColor;
  const MyElevatedButton(
      {super.key,
      required this.onTap,
      required this.name,
      required this.iconData,
      required this.backgroundColor, required this.mainColor});

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
            Icon(iconData,color: mainColor,),
            Text(
              name,
              style: TextStyle(fontSize: 16,color: mainColor),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
