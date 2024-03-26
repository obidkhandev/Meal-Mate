import 'package:meal_mate/utils/tools/file_importer.dart';

import '../screens/router/router.dart';




class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    LocalNotificationService.localNotificationService.init(navigatorKey);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);
        return AdaptiveTheme(
          light: AppTheme.lightTheme,
          dark: AppTheme.darkTheme,
          initial: AdaptiveThemeMode.light, builder: (light,dark) {
            return  MaterialApp(
              darkTheme: dark,
              theme: light,
              debugShowCheckedModeBanner: false,
              initialRoute: RouteName.splash,
              onGenerateRoute: AppRoute.generateRoute,
            );
        },

        );
      },
    );
  }
}
