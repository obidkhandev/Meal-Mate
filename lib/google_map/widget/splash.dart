import 'package:flutter/material.dart';
import 'package:meal_mate/google_map/ui/addresses_screen.dart';
import 'package:provider/provider.dart';

import '../../data/api_provider/api_provider.dart';
import '../../utils/colors/app_colors.dart';
import '../view_model/map_view_model.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddressesScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MapsViewModel>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Deafult"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: Text("LoTTIE QO"),
        ),
      ),
    );
  }
}