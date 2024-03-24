import 'package:meal_mate/screens/tab_box/profile/user_posts/tab_bar_user_posts.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

myAnimatedSnackBar(BuildContext context,String message){
  return AnimatedSnackBar(

      duration: const Duration(seconds: 2),
      builder: (context){
    return Container(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: AppColors.primary),
      ),
      width: width(context) * 0.9,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Text(
          message,
          maxLines: 5,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }).show(context);
}


showMyAlertDialog(BuildContext context, Function() onTap1, Function() onTap2, String actionName1,String actionName2,){
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AlertDialogIconButton(icon: Icons.edit, onTap: onTap1,actionName: actionName1,),
              AlertDialogIconButton(icon: Icons.delete, onTap: onTap2,actionName: actionName2,)
            ],
          ),
        );
      });
}

showErrorForRegister(
  String code,
  BuildContext context,
) {
  if (code == 'weak-password') {
    debugPrint('The password provided is too weak.');
    if (!context.mounted) return;
    myAnimatedSnackBar(
       context,
       "Passwordni xato kiritdingiz",
    );
  } else if (code == 'email-already-in-use') {
    debugPrint('The account already exists for that email.');
    if (!context.mounted) return;
    myAnimatedSnackBar(
      context,
       "Bu e-pochta uchun hisob allaqachon mavjud.",
    );
  }
}

showErrorForLogin(
  String code,
  BuildContext context,
) {
  if (code == 'wrong-password') {
    debugPrint('The password provided is wrong.');
    if (!context.mounted) return;
    myAnimatedSnackBar(
      context, "Passwordni xato kiritdingiz",
    );
  } else if (code == 'invalid-email') {
    debugPrint('The e-mail is invalid.');
    if (!context.mounted) return;
    myAnimatedSnackBar(
      context,
      "Bu e-pochta yaqroqsiz.",
    );
  } else if (code == 'user-disabled') {
    debugPrint('The user is blocked.');
    if (!context.mounted) return;
    myAnimatedSnackBar(
      context,
      "Foydalanuvchi bloklangan.",
    );
  } else {
    debugPrint('The user is not found.');
    if (!context.mounted) return;
    myAnimatedSnackBar(
       context,
       "Foydalanuvchi topilmadi.",
    );
  }
}
