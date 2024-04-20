import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/qr_code_scaner/bloc/product_blox.dart';
import 'package:meal_mate/qr_code_scaner/bloc/product_event.dart';
import 'package:meal_mate/qr_code_scaner/service/service_locator.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';
import 'app/app.dart';
import 'service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setUp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create:(_)=> TabViewModel()),
      ChangeNotifierProvider(create:(_)=> AuthViewModel()),
      ChangeNotifierProvider(create: (_)=>IngredientViewModel()),
      ChangeNotifierProvider(create: (_)=>ProductsViewModel()),
      ChangeNotifierProvider(create: (_)=>CategoryViewModel()),
      ChangeNotifierProvider(create: (_)=>StepsViewModel()),
      ChangeNotifierProvider(create: (_)=>NotificationViewModel()),
      BlocProvider(create: (_) => ProductBloc()..add(LoadProducts()))

    ],
    child: const App(),
    )
  );
}