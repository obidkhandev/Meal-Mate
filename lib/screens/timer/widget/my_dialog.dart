import 'package:meal_mate/utils/tools/file_importer.dart';

List<String> timerCategory = ["Study", "Homework", "Work", "Design", "Coding"];

 void myModalBottomSheet({
  required BuildContext context,
  required Widget dropDown,
   required Function() onTap,
   required Function() onSaveButtonTap
}) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {

        return Container(
          height: 400.h,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Set your time",
                style: AppTextStyle.recolateBold.copyWith(fontSize: 32),
              ),
              SizedBox(width: 30),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 IconButton(onPressed: onTap,icon: Icon(Icons.access_alarm,color: Colors.red,size: 40,)),
                 dropDown,
               ],
             ),
              SizedBox(width: 50),
              SizedBox(
                height: 46.h,
                width: width(context) * 0.7,
                child: ElevatedButton(
                  onPressed: onSaveButtonTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text("Save"),
                ),
              )
            ],
          ),
        );
      });
}
