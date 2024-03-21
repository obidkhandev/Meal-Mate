import '../../utils/tools/file_importer.dart';


class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return navigate(const SplashScreen());
      case RouteName.home:
        return navigate(const HomePage());
      case RouteName.signIn:
        return navigate(const SingInScreen());
      case RouteName.register:
        return navigate(const RegisterScreen());
      case RouteName.tabBox:
        return navigate(const TabBox());
      case RouteName.profile:
        return navigate(const ProfileScreen());

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("Bunday Screen Mavjud Emas"),
            ),
          ),
        );
    }
  }

  static navigate(Widget screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }
}