import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meal_mate/screens/singIn/view_model/sing_in_and_register_view_model.dart';
import 'package:meal_mate/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(

    MultiProvider(providers: [
      ChangeNotifierProvider(create:(_)=> SingInViewModel()),
    ],
    child: const App(),
    )
  );
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),

    );
  }
}
