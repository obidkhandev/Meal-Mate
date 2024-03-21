import 'package:meal_mate/screens/add_screen/view_model/add_view_model.dart';
import 'package:meal_mate/screens/add_screen/view_model/category_view_model.dart';
import 'package:meal_mate/screens/add_screen/view_model/ingredient_view_model.dart';
import 'package:meal_mate/screens/add_screen/view_model/steps_view_model.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';
import 'app/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create:(_)=> TabViewModel()),
      ChangeNotifierProvider(create:(_)=> AuthViewModel()),
      ChangeNotifierProvider(create: (_)=>IngredientViewModel()),
      ChangeNotifierProvider(create: (_)=>ProductsViewModel()),
      ChangeNotifierProvider(create: (_)=>CategoryViewModel()),
      ChangeNotifierProvider(create: (_)=>StepsViewModel()),
    ],
    child: const App(),
    )
  );
}



