import '../../utils/tools/file_importer.dart';

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
            hintText: "Email address",
            controller: emailController,
            isPassword: false,
            errorText: "Email Error",
            iconPath: Icon(Icons.email),
          ),
          SizedBox(height: 20),
          TextFieldItem(
            hintText: "Password",
            controller: passwordController,
            isPassword: true,
            errorText: "Password Error",
            iconPath: Icon(Icons.lock),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              context.read<AuthViewModel>().loginUser(
                context,
                email: emailController.text,
                password: passwordController.text,
              );
            },
            child: Text("Sing In"),

          ),
          ElevatedButton(onPressed: (){
            Navigator.pushReplacementNamed(context,RouteName.register);
          }, child: Text("Register"))
        ],
      ),
    );
  }
}
