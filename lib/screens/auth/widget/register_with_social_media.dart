import '../../../utils/tools/file_importer.dart';

class RegisterWithSocialMedia extends StatelessWidget {
  final String iconPath;
  final String title;
  final double width;
  final Function() onTap;

  const RegisterWithSocialMedia({super.key, required this.iconPath, required this.title, required this.width, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OnTap(
      onTap: onTap,
      child: Container(
        height: 46.h,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context)
                  .inputDecorationTheme
                  .border!
                  .borderSide
                  .color,
            )
          // shape: BoxShape.circle,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            SizedBox(width: 15.w),
            Text(
              title,
              style: AppTextStyle.recolateBlack.copyWith(
                fontFamily: "Cera Pro", fontSize: 18,),
            ),
          ],
        ),
      ),
    );
  }
}