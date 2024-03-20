import 'package:flutter/material.dart';
import 'package:meal_mate/screens/home/home_page.dart';
import 'package:meal_mate/screens/singIn/constants.dart';
import 'package:meal_mate/screens/singIn/text_from_field.dart';
import 'package:meal_mate/screens/singIn/view_model/sing_in_and_register_view_model.dart';
import 'package:provider/provider.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Text(
            "Welcome Back! 😊🤗🤗",
            style: TextStyle(fontSize: 32),
          ),
          SizedBox(height: 50),
          TextFieldItem(
            exp: AppValidates.emailExp,
            hintText: "Email address",
            controller: emailController,
            isPassword: false,
            errorText: "Email Error",
            iconPath: Icon(Icons.email),
          ),
          SizedBox(height: 20),
          TextFieldItem(
            exp: AppValidates.passwordExp,
            hintText: "Password",
            controller: passwordController,
            isPassword: true,
            errorText: "Password Error",
            iconPath: Icon(Icons.lock),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              try {
                context.read<SingInViewModel>().signInWithEmailAndPassword(
                    emailController.text, passwordController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePage(),
                  ),
                );
              } catch (error) {}
            },
            child: Text("Sing In"),
          ),
        ],
      ),
    );
  }
}
