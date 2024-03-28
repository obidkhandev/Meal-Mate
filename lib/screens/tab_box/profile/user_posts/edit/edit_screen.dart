import 'package:meal_mate/screens/widget/add_tab_bar1.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

import '../../../../add_screen/view_model/upload_file_view_model.dart';

class EditScreenState extends StatefulWidget {
  final String docId;

  const EditScreenState({super.key, required this.docId});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreenState> {

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController timeController;
  FoodModel? foodModel;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    timeController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchProductData();
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

            var foodModel = context.read<ProductsViewModel>().foodModel;
            if (foodModel != null) {
              context.read<ProductsViewModel>().updateProduct(
                foodModel.copWith(
                  foodDescription: descriptionController.text,
                  title: titleController.text,
                  timestamp: timeController.text,
                  imageUrl: context.read<ImageViewModel>().getImageUrl,
                ),
                context,
              );

              var notifModel = NotificationModel(
                title: titleController.text,
                id: DateTime.now().millisecond,
              );
              context.read<NotificationViewModel>().addToNotification(notifModel);

              LocalNotificationService().showNotification(
                notificationModel: notifModel,
                body: "Muvvaqqiyatli o'zgartirildi",
              );

              myAnimatedSnackBar(context, "Muvvaqqiyatli o'zgartirildi");
              Navigator.pop(context);
            }

        },
        child: Icon(Icons.save),
      ),
      body:  context.watch<ProductsViewModel>().getLoader ? Center(child: CircularProgressIndicator(),): Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                border: UnderlineInputBorder(),
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: "Description",
                border: UnderlineInputBorder(),
              ),
            ),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(
                hintText: "Time",
                border: UnderlineInputBorder(),
              ),
            ),

            if(context.watch<ImageViewModel>().getLoader)
                const Center(
                  child: CircularProgressIndicator(),
                ),

             foodModel!.imageUrl.isEmpty
                  ? ElevatedButton(
                  onPressed: () {
                     takeAnImage(context);
                  },
                  child: const Text("Upload Image"))
                  :
             SizedBox(height: 20),

             Container(
                height: 200.h,
                width: double.infinity,
                alignment: Alignment.topRight,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(foodModel!.imageUrl),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    takeAnImage(context);
                      foodModel?.imageUrl =  (context.watch<ImageViewModel>().getImageUrl) ?? '';
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
              ),
            ],

        ),
      ),
    );
  }

  void _fetchProductData() async {
    Future.microtask(() {
      return context.read<ProductsViewModel>().getProductFromId(widget.docId);
    });
    try {
      FoodModel? fetchedFoodModel =
          context.watch<ProductsViewModel>().foodModel;
      if (fetchedFoodModel != null) {
        setState(() {
          foodModel = fetchedFoodModel;
          titleController.text = foodModel!.title;
          descriptionController.text = foodModel!.foodDescription;
          timeController.text = foodModel!.timestamp;
        });
      }else{
        setState(() {});
      }
    } catch (error) {
      debugPrint("Update Error $error");
    }

  }
}
