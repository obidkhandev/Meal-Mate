import 'package:meal_mate/screens/add_screen/view_model/main_view_model.dart';
import 'package:meal_mate/screens/edit/edit_screen.dart';

import '../../../../utils/tools/file_importer.dart';

class TabBarUserPosts extends StatelessWidget {
  const TabBarUserPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        if (context.watch<ProductsViewModel>().ownProducts.isNotEmpty ) const Center(
          child: Text("Siz hali hech nima kiritmadingiz"),
        ) else StreamBuilder<List<FoodModel>>(
          stream: context
              .read<ProductsViewModel>()
              .getProductsByEmailStream(context
              .read<AuthViewModel>()
              .getUser!
              .email!),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return const Text(
                  'No products found for the user with email');
            } else {
              // Handle displaying the list of products
              List<FoodModel> list =
              snapshot.data as List<FoodModel>;
              return Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      FoodModel food = list[index];
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(15),
                          border: Border.all(
                              color: Colors.grey),
                        ),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120.h,
                              width: width(context) * 0.5,
                              padding:
                              const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(
                                    12),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    food.imageUrl,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Text(
                                    food.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      Text(
                                        "Difficultly: ",
                                        style: Theme.of(
                                            context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      Text(
                                        food.difficultly,
                                        style: Theme.of(
                                            context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (_) =>
                                                      EditScreen(),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors
                                                .green,
                                          )),
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<
                                              ProductsViewModel>()
                                              .deleteProduct(
                                              food.docId,
                                              context);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
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
