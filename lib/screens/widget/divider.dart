import '../../utils/tools/file_importer.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.symmetric(horizontal:  30.w,vertical: 20.h),
      child: Row(
        children: [
          SizedBox(
            width: width(context) / 3.5,
            child: const Divider(color:  AppColors.borderShade600,),
          ),
          SizedBox(width: 5.w),
          Text(
            "OR",
            style: AppTextStyle.recolateMedium
                .copyWith(fontFamily: "Cera Pro",color: AppColors.borderShade600),
          ),
          SizedBox(width: 5.w),
          SizedBox(
            width: width(context) / 3.5,
            child: const Divider(color:  AppColors.borderShade600,),
          ),
        ],
      ),
    );
  }
}
