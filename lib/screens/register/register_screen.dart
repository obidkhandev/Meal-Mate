import 'package:flutter/material.dart';
import 'package:meal_mate/screens/singIn/sign_in_screen.dart';
import 'package:provider/provider.dart';

import '../home/home_page.dart';
import '../singIn/constants.dart';
import '../singIn/text_from_field.dart';
import '../singIn/view_model/sing_in_and_register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    // emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Text(
              "Welcome to Meal\nMeat App",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "Please enter your account details below!",
              style: TextStyle(fontSize: 14),
            ),
            TextFieldItem(
              exp: AppValidates.nameExp,
              hintText: "Full Name",
              controller: nameController,
              isPassword: false,
              errorText: "Name Error",
              iconPath: Icon(Icons.person),
            ),
            SizedBox(height: 20),
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
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: (){
                try {
                 if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                   context.read<SingInViewModel>().registerWithEmailAndPassword(
                       emailController.text, passwordController.text);
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (_) => SingInScreen(),
                     ),
                   );
                 }else{
                   final snackBar = SnackBar(
                     content: const Text("Siz Hali hech nima kiritmadingiz"),
                     action: SnackBarAction(
                       label: 'Undo',
                       onPressed: () {
                         // Some code to undo the change.
                       },
                     ),
                   );

                   // Find the ScaffoldMessenger in the widget tree
                   // and use it to show a SnackBar.
                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                 }

                } catch (error) {
                  debugPrint(error.toString());
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff86BF3E),
                  // shape: BoxShape.circle,
                ),
                child: Text("Continue",style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
