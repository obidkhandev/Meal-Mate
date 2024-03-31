import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meal_mate/google_map/view_model/location_view_model.dart';
import 'package:meal_mate/service/firebase_options.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'google_map/view_model/addresses_view_model.dart';
import 'google_map/view_model/adressesViewModel.dart';
import 'google_map/view_model/map_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MapsViewModel()),
      ChangeNotifierProvider(create: (_) => AddressesViewModel()),
      ChangeNotifierProvider(create: (_) => AddressesViewModel2()),
      ChangeNotifierProvider(create: (_) => LocationViewModel()),
    ],
    child: App(),
  ));
}
