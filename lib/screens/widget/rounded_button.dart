
import '../../utils/tools/file_importer.dart';

class RoundedButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  const RoundedButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: width(context),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          // shape: BoxShape.circle,
        ),
        child: Text(
          title,
          style: AppTextStyle.recolateBlack.copyWith(
              fontFamily: "Cera Pro", fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
