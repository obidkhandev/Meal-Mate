import '../../../../utils/tools/file_importer.dart';

class CommunityItemWidget extends StatelessWidget {
  const CommunityItemWidget({
    super.key,
    required this.foodModel,
  });

  final FoodModel foodModel;

  @override
  Widget build(BuildContext context) {
    return OnTap(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteName.detail,
          arguments: foodModel.docId,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.h,
              alignment: Alignment.bottomRight,
              width: width(context) * 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(foodModel.imageUrl),
                ),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
                color: Colors.white,
                iconSize: 32.sp,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              foodModel.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 5.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(foodModel.imageUrl),
                ),
                SizedBox(width: 10.w),
                RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "${foodModel.userName}\n",
                          style: Theme.of(context).textTheme.titleMedium),
                      TextSpan(
                        text: "0 Like",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.borderShade600),
                      ),
                    ])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}