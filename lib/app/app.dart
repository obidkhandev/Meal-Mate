import 'package:meal_mate/google_map/widget/splash.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

import '../google_map/ui/ui.dart';
import '../screens/router/router.dart';




class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

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
              home: const MySplashScreen(),
            );
        },

        );
      },
    );
  }
}
