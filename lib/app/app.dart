import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/screens/router/router.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

import '../screens/splash/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteName.splash,
          onGenerateRoute: AppRoute.generateRoute,
        );
      },

    );
  }
}