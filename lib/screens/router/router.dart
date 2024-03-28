import 'package:meal_mate/screens/add_screen/add_screen.dart';
import 'package:meal_mate/screens/detail/detail_screen.dart';
import 'package:meal_mate/screens/tab_box/profile/user_posts/edit/edit_screen.dart';

import '../../utils/tools/file_importer.dart';


class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    var arg = settings.arguments;
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
      case RouteName.addRecipe:
        return navigate(const AddScreen());
        case RouteName.edit:
        return navigate(EditScreenState(docId: settings.arguments as String,));
      case RouteName.detail:
        return navigate(DetailScreen(uid: arg as String));

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
