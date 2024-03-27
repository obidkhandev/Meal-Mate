import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';
import 'app/app.dart';
import 'service/firebase_options.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
      "BACKGROUND MODE DA PUSH NOTIFICATION KELDI:${message.notification!.title}");
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance.subscribeToTopic("news");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create:(_)=> TabViewModel()),
      ChangeNotifierProvider(create:(_)=> AuthViewModel()),
      ChangeNotifierProvider(create: (_)=>IngredientViewModel()),
      ChangeNotifierProvider(create: (_)=>ProductsViewModel()),
      ChangeNotifierProvider(create: (_)=>CategoryViewModel()),
      ChangeNotifierProvider(create: (_)=>StepsViewModel()),
      ChangeNotifierProvider(create: (_)=>NotificationViewModel()),
    ],
    child: const App(),
    )
  );
}