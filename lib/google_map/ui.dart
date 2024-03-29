import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meal_mate/google_map/view_model/map_view_model.dart';
import 'package:meal_mate/google_map/widget/my_tab_item.dart';
import 'package:meal_mate/google_map/widget/show_modal_bottom_sheet.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({
    super.key,
  });

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  int notifId = 1;
  bool isMyLocation = true;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void dispose() {
    bodyController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition? cameraPosition;
    return Scaffold(
      body: Consumer<MapsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.initialCameraPosition == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                // zoomGesturesEnabled: false,
                markers: viewModel.markers,
                onCameraIdle: () {
                  if (cameraPosition != null) {
                    context
                        .read<MapsViewModel>()
                        .changeCurrentLocation(cameraPosition!);
                    context.read<MapsViewModel>().addNewMarker(
                          lang: titleController.text,
                          lat: bodyController.text,
                        );
                    titleController.clear();
                    bodyController.clear();
                  }

                  LocalNotificationService().showNotification(
                      notificationModel:
                          NotificationModel(title: "Diqqat!!!", id: notifId),
                      body: "${cameraPosition!.target}");
                  notifId++;
                },
                onCameraMove: (CameraPosition currentCameraPosition) {
                  cameraPosition = currentCameraPosition;
                  debugPrint(
                      "CURRENT POSITION:${currentCameraPosition.target.longitude}");
                },
                mapType: viewModel.mapType,
                initialCameraPosition: viewModel.initialCameraPosition!,
                onMapCreated: (GoogleMapController createdController) {
                  viewModel.controller.complete(createdController);
                },
              ),
              const Align(
                  child: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 26,
              ))
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              context.read<MapsViewModel>().moveToInitialPosition();
              setState(() {
                isMyLocation = true;
              });
            },
            child: Icon(
              isMyLocation ? Icons.my_location : Icons.location_searching,
              color: Colors.lightBlueAccent,
            ),
          ),
          SizedBox(height: 10.h),
          const MapTypeItem(),
          SizedBox(height: 10.h),
          MapCategoryItem(
            myShowModalBottomSheet: MyBottomSheetWidget(titleController: titleController, bodyController: bodyController),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}


