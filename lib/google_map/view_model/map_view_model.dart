
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../data/api_provider/api_provider.dart';
import '../../data/model/place_category.dart';
import '../../data/model/place_model.dart';

class MapsViewModel extends ChangeNotifier {
  MapsViewModel() {
    getUserLocation();
  }

  String currentPlaceName = "";

  final Completer<GoogleMapController> controller =
  Completer<GoogleMapController>();

  MapType mapType = MapType.normal;

  late CameraPosition initialCameraPosition;
  late CameraPosition currentCameraPosition;
  Set<Marker> markers = {};

  List<PlaceModel> myAddresses = [];

  setLatInitialLong(LatLng latLng) {
    initialCameraPosition = CameraPosition(
      target: latLng,
      zoom: 15,
    );
    notifyListeners();
  }

  changeMapType(MapType newMapType) {
    mapType = newMapType;
    notifyListeners();
  }

  moveToInitialPosition() async {
    final GoogleMapController mapController = await controller.future;
    await mapController
        .animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition!));
  }

  changeCurrentCameraPosition(CameraPosition cameraPosition) async {
    final GoogleMapController mapController = await controller.future;
    await mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  changeCurrentLocation(CameraPosition cameraPosition) async {
    currentCameraPosition = cameraPosition;
    currentPlaceName =
    await ApiProvider.getPlaceNameByLocation(cameraPosition.target);
    notifyListeners();
  }

  addNewMarker(PlaceModel placeModel) async {
    markers = {};

    Uint8List? markerImage;

    switch (placeModel.placeCategory) {
      case PlaceCategory.work:
        markerImage = await getBytesFromAsset(
          "assets/icons/9090616a-95e2-457b-ac24-1ed2c7e01c51.png",
          80,
        );
        break;
      case PlaceCategory.home:
        markerImage = await getBytesFromAsset(
          "assets/icons/89ccd7ea-e18d-41c9-86ed-d0b08327fee4.png",
          80,
        );
      case PlaceCategory.other:
        markerImage = await getBytesFromAsset(
          "assets/icons/fee230f4-943c-4de9-bf03-e435b5a3bbeb.png",
          80,
        );
    }

    markers.add(
      Marker(
        position: LatLng(placeModel.lat, placeModel.long),
        infoWindow: InfoWindow(
          title: placeModel.placeName,
          snippet: placeModel.placeCategory,
        ),
        //BitmapDescriptor.defaultMarker,
        icon: BitmapDescriptor.fromBytes(markerImage!),
        markerId: MarkerId(DateTime.now().toString()),
      ),
    );
    notifyListeners();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  savePlace(PlaceModel placeModel) {
    myAddresses.add(placeModel);
    addNewMarker(placeModel);
  }

  Future<void> getUserLocation() async {
    Location location = Location();
    bool serviceEnabled = false;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    setLatInitialLong(LatLng(locationData.latitude!, locationData.longitude!));
  }
}
