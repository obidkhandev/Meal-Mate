import '../../../utils/tools/file_importer.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            StreamBuilder<List<FoodModel>>(
                stream: context.read<ProductsViewModel>().listenProducts(),
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
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Text(food.title),
                              ],
                            );
                          }),
                    );
                  }
                }),
          ],
        ));
  }
}
