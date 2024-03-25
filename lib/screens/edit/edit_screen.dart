import 'package:meal_mate/utils/tools/file_importer.dart';

class EditScreen extends StatefulWidget {
  final String docId;

  const EditScreen({super.key, required this.docId});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  _fetchProductData() {
    Future.microtask(() {
      try {
        context.read<ProductsViewModel>().getProductFromId(widget.docId);
        FoodModel? foodModel = context.read<ProductsViewModel>().foodModel;
        if (foodModel != null) {
          context.read<ProductsViewModel>().foodModel = foodModel;
        } else {
          debugPrint("Update Error");
        }
      } catch (error) {
        debugPrint("Update Error $error");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProductData();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController time = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FoodModel? foodModel = context.read<ProductsViewModel>().foodModel;
          context.read<ProductsViewModel>().updateProduct(
              foodModel!.copWith(
                  foodDescription: descriptionController.text,
                  title: titleController.text,
                  timestamp: time.text),
              context);
          LocalNotificationService().showNotification(
              notificationModel: NotificationModel(
                  title: titleController.text, id: DateTime.now().millisecond),
              body: "Muvvaqqiyatli o'zgartirildi");
          myAnimatedSnackBar(context, "Mufuvvaqqiyatli o'zgartirildi");
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
      body: context.read<ProductsViewModel>().foodModel == null
          ? Center(child: Text("Empty"))
          : Padding(
              padding: EdgeInsets.all(16.0.h),
              child: Column(
                children: [
                  TextField(
                    controller: titleController
                      ..text =
                          context.watch<ProductsViewModel>().foodModel!.title,
                    decoration: const InputDecoration(
                        hintText: "Title", border: UnderlineInputBorder()),
                  ),
                  TextField(
                    controller: descriptionController
                      ..text = context
                          .watch<ProductsViewModel>()
                          .foodModel!
                          .foodDescription,
                    decoration: const InputDecoration(
                        hintText: "Description",
                        border: UnderlineInputBorder()),
                  ),
                  TextField(
                    controller: time
                      ..text = context
                          .watch<ProductsViewModel>()
                          .foodModel!
                          .timestamp,
                    decoration: const InputDecoration(
                        hintText: "Time", border: UnderlineInputBorder()),
                  ),
                ],
              ),
            ),
    );
  }
}
