import 'package:meal_mate/screens/auth/widget/register_with_social_media.dart';

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
                SizedBox(height: 20.h),
                RoundedButton(
                    title: "Login",
                    onTap: () {
                      context.read<AuthViewModel>().loginUser(
                            context,
                            email: emailController.text,
                            password: passwordController.text,
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
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account with us?",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RouteName.register);
                      },
                      child: Text(
                        "Sing Up",
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
