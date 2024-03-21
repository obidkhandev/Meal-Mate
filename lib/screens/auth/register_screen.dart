import 'package:meal_mate/screens/auth/widget/register_with_social_media.dart';

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
      body: context.watch<AuthViewModel>().loading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primary.withOpacity(0.8),
              ),
            )
          : ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              padding: EdgeInsets.all(20.sp),
              children: [
                SizedBox(height: 70.h),
                Center(
                  child: Text("Meal Mate",
                      style: Theme.of(context).textTheme.headlineLarge),
                ),
                Center(
                  child: Text("Everyone can be a chef",
                      style: Theme.of(context).textTheme.titleSmall),
                ),
                SizedBox(height: 20.h),
                TextFieldItem(
                  hintText: "Full Name",
                  controller: nameController,
                  isPassword: false,
                  errorText: "Name Error",
                  iconPath: Icon(
                    Icons.person,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                SizedBox(height: 20.h),
                TextFieldItem(
                  hintText: "Email address",
                  controller: emailController,
                  isPassword: false,
                  errorText: "Email Error",
                  iconPath: Icon(Icons.email,
                      color: Theme.of(context).iconTheme.color),
                ),
                SizedBox(height: 20.h),
                TextFieldItem(
                  hintText: "Password",
                  controller: passwordController,
                  isPassword: true,
                  errorText: "Password Error",
                  iconPath: Icon(Icons.lock_open_rounded,
                      color: Theme.of(context).iconTheme.color),
                ),
                SizedBox(height: 40.h),
                RoundedButton(
                    title: "Sign Up",
                    onTap: () {
                      context.read<AuthViewModel>().registerUser(
                            context,
                            email: emailController.text,
                            password: passwordController.text,
                            username: nameController.text,
                          );
                    }),
                const MyDivider(),
                RegisterWithSocialMedia(
                  width: double.infinity,
                  title: "Continue with Google",
                  iconPath: AppImages.googleLogo,
                  onTap: () {},
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegisterWithSocialMedia(
                      width: width(context) / 2.4,
                      title: "Facebook",
                      iconPath: AppImages.facebookLogo,
                      onTap: () {},
                    ),
                    RegisterWithSocialMedia(
                      width: width(context) / 2.4,
                      title: "Apple",
                      iconPath: AppImages.appleLogo,
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account with us?",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RouteName.signIn);
                      },
                      child: Text(
                        "Login",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
