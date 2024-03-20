import 'package:flutter/material.dart';
import 'package:meal_mate/screens/register/register_screen.dart';
import 'package:meal_mate/screens/singIn/sign_in_screen.dart';
import 'package:meal_mate/screens/singIn/view_model/sing_in_and_register_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.microtask(() {
      if (context.read<SingInViewModel>().checkCurrentUser()) {
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SingInScreen()
          ),
        );
      }else{
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {

              },
              child: Text("Get Ready"),
            )
          ],
        ),
      ),
    );
  }
}
