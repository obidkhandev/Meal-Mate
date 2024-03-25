import 'package:meal_mate/service/local_notification_service.dart';

import '../../../../utils/tools/file_importer.dart';

class TabBarUserPosts extends StatelessWidget {
  const TabBarUserPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (context.watch<ProductsViewModel>().ownProducts.isNotEmpty)
          const Center(
            child: Text("Siz hali hech nima kiritmadingiz"),
          )
        else
          StreamBuilder<List<FoodModel>>(
            stream: context.read<ProductsViewModel>().getProductsByEmailStream(
                context.read<AuthViewModel>().getUser!.email!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No products found for the user with email');
              } else {
                // Handle displaying the list of products
                List<FoodModel> list = snapshot.data as List<FoodModel>;
                return Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        FoodModel food = list[index];
                        return Container(
                          // padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 120.h,
                                width: width(context) * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.r),
                                    bottomLeft:  Radius.circular(12.r),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      food.imageUrl,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: width(context) * 0.3,
                                          child: Text(
                                            food.title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                             showMyAlertDialog(context,(){
                                               Navigator.pop(context);
                                               debugPrint(food.docId);
                                               Navigator.pushNamed(context, RouteName.edit,arguments: food.docId);
                                             },() {
                                              context
                                                  .read<
                                              ProductsViewModel>()
                                                  .deleteProduct(
                                              food.docId,
                                              context);
                                              Navigator.pop(context);
                                              },"Edit","Delete");
                                            },
                                            icon: SvgPicture.asset(
                                              "assets/icons/options.svg",
                                              height: 16.h,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        Text(
                                          "Difficultly: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        Text(
                                          food.difficultly,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }
            },
          )
      ],
    );
  }
}

class AlertDialogIconButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final String actionName;

  const AlertDialogIconButton(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.actionName});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(width: 20.w),
          Text(actionName)
        ],
      ),
    );
  }
}
