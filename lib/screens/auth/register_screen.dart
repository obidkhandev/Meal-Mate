import '../../utils/tools/file_importer.dart';


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
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(height: 80),
          Center(
            child: Text(
              "Meat App",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Everyone can be a chef",
            style: Theme.of(context).textTheme.titleSmall
          ),
          TextFieldItem(
            hintText: "Full Name",
            controller: nameController,
            isPassword: false,
            errorText: "Name Error",
            iconPath: Icon(Icons.person),
          ),
          SizedBox(height: 20),
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
          IconButton(
            // borderRadius: BorderRadius.circular(20),
            onPressed: (){
              context.read<AuthViewModel>().registerUser(
                context,
                email: emailController.text,
                password: passwordController.text,
                username: nameController.text,
              );
            },
            icon: Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
      
              decoration: BoxDecoration(
                color: Color(0xff86BF3E),
              borderRadius: BorderRadius.circular(12),
                // shape: BoxShape.circle,
              ),
              child: Text("Continue",style: TextStyle(color: Colors.white),),
            ),
          ),
          ElevatedButton(onPressed: (){
            Navigator.pushReplacementNamed(context,RouteName.register);
          }, child: Text("Register"))
        ],
      ),
    );
  }
}
