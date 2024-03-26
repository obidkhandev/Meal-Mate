import '../../../utils/tools/file_importer.dart';
import 'widget/community_detail.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<ProductsViewModel>().getLoader
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const GlobalAppBar(
                  title: "Community",
                ),
                StreamBuilder<List<FoodModel>>(
                  stream: context.read<ProductsViewModel>().listenProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          heightFactor: 10.h,
                          child: const CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text(
                          'No products found for the user with email');
                    } else {
                      // Handle displaying the list of products
                      List<FoodModel> list = snapshot.data as List<FoodModel>;
                      return Expanded(
                        child: GridView.builder(
                          itemCount: list.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            // crossAxisSpacing: 10,
                            mainAxisExtent: 265.h,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            FoodModel foodModel = list[index];
                            return CommunityItemWidget(foodModel: foodModel);
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
    );
  }
}
