import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meal_mate/google_map/ui.dart';
import 'package:provider/provider.dart';

import '../view_model/location_view_model.dart';
import '../view_model/map_view_model.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LocationViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Splash Screen"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            LatLng? latLng = context.read<LocationViewModel>().latLng;
            if (latLng != null) {
              Provider.of<MapsViewModel>(context, listen: false)
                  .setLatInitialLong(latLng);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GoogleMapsScreen();
                  },
                ),
              );
            }
          },
          child: Text("GOOGLE MAPS OYNASI"),
        ),
      ),
    );
  }
}