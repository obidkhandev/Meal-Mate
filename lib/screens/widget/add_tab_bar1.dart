import '../../data/model/category_model.dart';
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

  int activeIndex  = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      children: [
        TextField(
          controller: widget.titleController,
          decoration: InputDecoration(
              hintText: "Title", border: UnderlineInputBorder()),
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
                decoration: InputDecoration(
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
                    hintText: "minute", border: UnderlineInputBorder()),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Container(
          height: 200.h,
          width: double.infinity,
          alignment: Alignment.topRight,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://i.pinimg.com/originals/20/63/25/206325d9203e6b3c5b79cfc5202ce046.jpg"),
            ),
          ),
          child: Icon(
            Icons.edit,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20.h),
        TextField(
          controller: widget.descriptionController,
          maxLines: null,
          decoration: InputDecoration(
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
