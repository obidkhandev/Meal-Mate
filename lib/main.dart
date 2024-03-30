import 'package:flutter/material.dart';
import 'package:meal_mate/google_map/view_model/location_view_model.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'google_map/view_model/addresses_view_model.dart';
import 'google_map/view_model/map_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MapsViewModel()),
      ChangeNotifierProvider(create: (_) => AddressesViewModel()),
      ChangeNotifierProvider(create: (_) => LocationViewModel()),
    ],
    child: App(),
  ));
}
