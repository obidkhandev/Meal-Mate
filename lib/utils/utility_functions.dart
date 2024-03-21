import 'package:meal_mate/utils/tools/file_importer.dart';

myAnimatedSnackBar(BuildContext context,String message){
  return AnimatedSnackBar(
      duration: const Duration(seconds: 3),
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
