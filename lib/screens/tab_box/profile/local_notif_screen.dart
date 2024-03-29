import 'package:meal_mate/google_map/view_model/map_view_model.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

class LocalNotifScreen extends StatelessWidget {
  const LocalNotifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Siz borgan joylar"),
        actions: [
          TextButton(
            onPressed: () {
              context.read<MapsViewModel>().clearMarkers();
              context.read<NotificationViewModel>().removeAll();
              Navigator.pop(context);
              },
            child: const Text("Clear all place"),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          context.watch<NotificationViewModel>().notifications.isEmpty
              ? Center(
                  heightFactor: height(context) / 30,
                  child: const Text("Siz hali hech qayerga bormadingiz"),
                )
              : Consumer<NotificationViewModel>(
                  builder: (context, viewModel, child) {
                  return SizedBox(
                    height: 700.h,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: viewModel.notifications.length,
                      itemBuilder: (context, index) {
                        NotificationModel notifModel =
                            viewModel.notifications[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          margin: EdgeInsets.symmetric(vertical: 10.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey.shade200)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(notifModel.title),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                      width: 200.w,
                                      child: Text(notifModel.body,overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  LocalNotificationService()
                                      .cancelNotification(notifModel.id);
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
