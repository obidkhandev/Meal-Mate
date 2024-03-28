import 'package:meal_mate/screens/persmissions/permission_screen.dart';
import 'package:meal_mate/screens/tab_box/profile/local_notif_screen.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Account",
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium,
        ),
      ),
      body: context
          .watch<AuthViewModel>()
          .loading
          ? const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      )
          : Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text:
                        "${context
                            .watch<AuthViewModel>()
                            .getUser!
                            .displayName ?? ""}\n",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge),
                    TextSpan(
                        text:
                        "${context
                            .watch<AuthViewModel>()
                            .getUser!
                            .email ?? ""}\n",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall),
                  ]),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AuthViewModel>().updateImageUrl(
                        "https://www.clipartmax.com/png/full/267-2671061_yükle-youssefdibeyoussefdibe-profile-picture-user-male.png");
                  },
                  child: Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(context
                            .watch<AuthViewModel>()
                            .getUser!
                            .photoURL ??
                            "https://www.kindpng.com/picc/m/269-2697881_computer-icons-user-clip-art-transparent-png-icon.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfileSettings(
                  icon: Icon(Icons.favorite_border,
                      color: Theme
                          .of(context)
                          .iconTheme
                          .color),
                  title: "Liked Recipe",
                ),
                ProfileSettings(
                  icon: Icon(Icons.notifications_none_outlined,
                      color: Theme
                          .of(context)
                          .iconTheme
                          .color),
                  title: "Notification",
                ),
                ProfileSettings(
                  icon: Icon(Icons.settings,
                      color: Theme
                          .of(context)
                          .iconTheme
                          .color),
                  title: "Setting",
                )
              ],
            ),
            SizedBox(height: 10.h),
            const Divider(),
            SizedBox(height: 10.h),
            Text("General",
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge),
            const SizedBox(height: 20),
            ProfileGeneralItem(text: "About", onTap: () {}),
            ProfileGeneralItem(
                text: "Add Posts",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddScreen()),
                  );
                }),
            ProfileGeneralItem(
                text: "My Posts",
                onTap: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const UsersPost()));
                }),
            ProfileGeneralItem(
                text: "Permissions",
                onTap: () async {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PermissionExampleScreen()));
                }),
            ProfileGeneralItem(
                text: "Logout",
                onTap: () {
                  context.read<AuthViewModel>().logout(context);
                }),
          ],
        ),
      ),
    );
  }
}

class ProfileGeneralItem extends StatelessWidget {
  final String text;
  final Function() onTap;

  const ProfileGeneralItem(
      {super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OnTap(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme
                .of(context)
                .textTheme
                .titleMedium,
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}

class ProfileSettings extends StatelessWidget {
  final Icon icon;
  final String title;

  const ProfileSettings({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        SizedBox(height: 5.h),
        Text(title),
      ],
    );
  }
}
