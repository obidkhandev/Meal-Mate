import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsViewModel extends ChangeNotifier {
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  MapType mapType = MapType.normal;
  CameraPosition? initialCameraPosition;
  late CameraPosition currentCameraPosition;
  String mapIcon = 'assets/icons/inital_map_icon.png';

  Set<Marker> markers = {};


  clearMarkers(){
    markers = {};
    notifyListeners();
  }

  setLatInitialLong(LatLng latLng) {
    initialCameraPosition = CameraPosition(
      target: latLng,
      zoom: 15,
    );

    currentCameraPosition = initialCameraPosition!;
    // addNewMarker();
  }

  changeMapIcon(String iconPath) {
    mapIcon = iconPath;
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

  changeCurrentLocation(CameraPosition cameraPosition) {
    currentCameraPosition = cameraPosition;
  }

  addNewMarker({
    required String lang,
    required String lat,
  }) async {
    Uint8List markerImage = await getBytesFromAsset(
      mapIcon,
      50,

    );
    markers.add(
      Marker(
        position: currentCameraPosition.target,
        infoWindow: InfoWindow(
            title: lang,
            snippet: lat,
        ),
        icon: BitmapDescriptor.fromBytes(markerImage),
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
}
