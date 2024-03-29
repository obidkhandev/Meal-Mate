import 'package:meal_mate/google_map/view_model/location_view_model.dart';
import 'package:meal_mate/google_map/view_model/map_view_model.dart';
import 'package:meal_mate/screens/add_screen/view_model/upload_file_view_model.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';
import 'app/app.dart';
import 'service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  LocalNotificationService.localNotificationService.init(navigatorKey);

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create:(_)=> TabViewModel()),
      ChangeNotifierProvider(create:(_)=> AuthViewModel()),
      ChangeNotifierProvider(create: (_)=>IngredientViewModel()),
      ChangeNotifierProvider(create: (_)=>ProductsViewModel()),
      ChangeNotifierProvider(create: (_)=>CategoryViewModel()),
      ChangeNotifierProvider(create: (_)=>StepsViewModel()),
      ChangeNotifierProvider(create: (_)=>NotificationViewModel()),
      ChangeNotifierProvider(create: (_)=>ImageViewModel()),
      ChangeNotifierProvider(create: (_)=>MapsViewModel()),
      ChangeNotifierProvider(create: (_)=>LocationViewModel()),
      // ChangeNotifierProvider(create: (_)=()),


    ],
    child: const App(),
    )
  );
}