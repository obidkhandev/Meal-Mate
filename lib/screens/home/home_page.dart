import 'package:flutter/material.dart';
import 'package:meal_mate/screens/register/register_screen.dart';
import 'package:meal_mate/screens/singIn/view_model/sing_in_and_register_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text("Lo"),
          leading: IconButton(
        onPressed: () {
          context.read<SingInViewModel>().logOut();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RegisterScreen(),
            ),
          );
        },
        icon: Icon(Icons.logout_sharp, color: Colors.red),
      )),
      body: Center(
        child: Text("Welcome to Home Page"),
      ),
    );
  }
}
