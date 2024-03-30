import '../../utils/tools/file_importer.dart';

class MyBottomSheetWidget extends StatelessWidget {
  const MyBottomSheetWidget({
    super.key,
    required this.titleController,
    required this.bodyController, required this.onTap,
  });
  final Function() onTap;
  final TextEditingController titleController;
  final TextEditingController bodyController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Title",
              contentPadding: EdgeInsets.symmetric(vertical: 13.h),
              border: InputBorder.none,
              filled: true,
            ),
          ),
          SizedBox(height: 20.h),
          TextField(
            controller: bodyController,
            decoration: InputDecoration(
              hintText: "Body",
              contentPadding: EdgeInsets.symmetric(vertical: 13.h),
              border: InputBorder.none,
              filled: true,
            ),
          ),
          SizedBox(height: 30.h),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent),
            child: Text(
              "Done",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}