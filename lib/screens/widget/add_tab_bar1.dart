import 'package:meal_mate/screens/add_screen/view_model/upload_file_view_model.dart';
import '../../utils/tools/file_importer.dart';


class AddTabBar extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController minuteController;
  final TextEditingController hourController;
  final TextEditingController descriptionController;

  const AddTabBar(
      {super.key,
      required this.titleController,
      required this.minuteController,
      required this.hourController,
      required this.descriptionController});

  @override
  State<AddTabBar> createState() => _AddTabBarState();
}

class _AddTabBarState extends State<AddTabBar> {
  int activeIndex = 0;
  // myImageUrl = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      children: [
        TextField(
          controller: widget.titleController,
          decoration: const InputDecoration(
            hintText: "Title",
            border: UnderlineInputBorder(),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          "Cook Time",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50.h,
              width: width(context) / 2.8,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: widget.hourController,
                decoration: const InputDecoration(
                    hintText: "hour", border: UnderlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: width(context) / 2.8,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: widget.minuteController,
                decoration: const InputDecoration(
                  hintText: "minute",
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        if (context.watch<ImageViewModel>().getLoader)
          const Center(
            child: CircularProgressIndicator(),
          ),
        context.watch<ImageViewModel>().getImageUrl.isEmpty
            ? ElevatedButton(
                onPressed: () {
                  takeAnImage(context);
                },
                child: const Text("Upload Image"))
            : Container(
                height: 200.h,
                width: double.infinity,
                alignment: Alignment.topRight,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(context.watch<ImageViewModel>().getImageUrl),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    takeAnImage(context);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
              ),
        SizedBox(height: 20.h),
        TextField(
          controller: widget.descriptionController,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: "description",
            border: UnderlineInputBorder(),
          ),
        ),
        SizedBox(height: 30.h),
        SizedBox(
          height: 30,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: CategoryEnum.values.length,
              itemBuilder: (context, index) {
                return OnTap(
                  onTap: () {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                  child: Container(
                    height: 45.h,
                    // width: 30.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: activeIndex == index
                          ? AppColors.primary
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14.sp),
                      border: Border.all(
                          color: activeIndex == index
                              ? AppColors.primary
                              : Colors.grey),
                    ),
                    child: Text(CategoryEnum.values[index].name),
                  ),
                );
              }),
        ),
        Text(
          "Easy",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }


}

takeAnImage(BuildContext context) async {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            ListTile(
              onTap: () async {

                await context.read<ImageViewModel>().getImageFromGallery(context);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.photo_album_outlined),
              title: const Text("Gallereyadan olish"),
            ),
            ListTile(
              onTap: () async {

                await context.read<ImageViewModel>().getImageFromCamera(context);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.camera_alt),
              title: const Text("Kameradan olish"),
            ),
            SizedBox(height: 24.h),
          ],
        );
      });
}
