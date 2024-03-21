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
    ],
    child: const App(),
    )
  );
}



