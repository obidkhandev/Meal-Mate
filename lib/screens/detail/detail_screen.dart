import 'package:meal_mate/utils/tools/file_importer.dart';

class DetailScreen extends StatefulWidget {
  final String uid;

  const DetailScreen({super.key, required this.uid});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
   _init();
  }

  // FoodModel? foodModel;

  Future<void> _init() async {
    Future.microtask(
        () => context.read<ProductsViewModel>().getProductFromId(widget.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          context.watch<ProductsViewModel>().getLoader? CircularProgressIndicator():
          Stack(
        children: [
          Container(
            height: height(context) * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(context.watch<ProductsViewModel>().getFood.imageUrl),
              ),
            ),
          ),
          // Text(foodModel!.userName),
        ],
      ),
    );
  }
}
