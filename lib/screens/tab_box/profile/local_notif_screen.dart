import 'package:meal_mate/screens/tab_box/profile/notif_model.dart';
import 'package:meal_mate/screens/tab_box/profile/notifc_view_model.dart';
import 'package:meal_mate/service/local_notification_service.dart';
import 'package:meal_mate/utils/tools/assistant.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

class LocalNotifScreen extends StatelessWidget {
  const LocalNotifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Notification"),
        actions: [
          TextButton(onPressed: (){
            context.read<NotificationViewModel>().removeAll();
            myAnimatedSnackBar(context, "Local notifications remove all");
          }, child: Text("Clear All")),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          context.watch<NotificationViewModel>().notifications.isEmpty
              ?  Center(
            heightFactor: height(context) / 30,
                  child: Text("Siz hali notification qabul qilmadingiz"),
                )
              : Consumer<NotificationViewModel>(builder: (context,viewModel,child){
                return SizedBox(
                  height: 700.h,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount:viewModel
                        .notifications
                        .length,
                    itemBuilder: (context, index) {
                      NotificationModel notifModel = viewModel
                          .notifications[index];
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey.shade200)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(notifModel.title),
                            IconButton(
                              onPressed: () {
                                LocalNotificationService().cancelNotification(notifModel.id);
                                viewModel.removeFromList(notifModel);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
          })
        ],
      ),
    );
  }
}
