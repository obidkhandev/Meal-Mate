import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/tools/file_importer.dart';
import '../view_model/location_view_model.dart';
import '../view_model/maps_view_model.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  LatLng? latLng;
  _init() async {
    Future.microtask(() {
     latLng = context.read<LocationViewModel>().latLng;
      if (latLng != null) {
        Provider.of<MapsViewModel>(context, listen: false)
            .setLatInitialLong(latLng!);
      }
        return;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(initialCameraPosition: context.read<MapsViewModel>().initialCameraPosition!,),
    );
  }
}
