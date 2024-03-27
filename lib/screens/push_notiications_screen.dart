import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meal_mate/data/network_model/network_model.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

class PushNotificationScreen extends StatefulWidget {
  const PushNotificationScreen({super.key});

  @override
  State<PushNotificationScreen> createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  String fcmToken = "";
  int id = 1;

  void init() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    debugPrint("FCM TOKEN:$fcmToken");

    final token = await FirebaseMessaging.instance.getAPNSToken();

    debugPrint("getAPNSToken : ${token.toString()}");

    LocalNotificationService.localNotificationService;
    //Foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteMessage) {
        if (remoteMessage.notification != null) {
          LocalNotificationService().showNotification(
            body: remoteMessage.notification!.body!,
            notificationModel: NotificationModel(
              title: remoteMessage.notification!.title!,
              id: id,
            ),
          );
          id++;

          debugPrint(
              "FOREGROUND NOTIFICATION:${remoteMessage.notification!.title}");
        }
      },
    );
    //Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      debugPrint("ON MESSAGE OPENED APP:${remoteMessage.notification!.title}");
    });
    // Terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint("TERMINATED:${message.notification?.title}");
      }
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  bool isSubscribe = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void dispose() {
    bodyController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover Any News"),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                isSubscribe == false
                    ? FirebaseMessaging.instance.subscribeToTopic("news")
                    : FirebaseMessaging.instance.unsubscribeFromTopic("news");
                isSubscribe = !isSubscribe;
                setState(() {});
              },
              child: Text(
                isSubscribe == false ? "Subscribe" : "UnSubscribe",
                style: AppTextStyle.recolateBlack.copyWith(
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "title",
              ),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                hintText: "body",
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () async {
                if (isSubscribe) {
                  Object messageId =
                      await ApiProvider().sendNotificationToUsers(
                    fcmToken: fcmToken,
                    newText: titleController.text,
                    newTitle: bodyController.text,
                    title: titleController.text,
                    body: bodyController.text,
                  );
                  debugPrint("MESSAGE ID:$messageId");
                } else {
                  Object messageId =
                      await ApiProvider().sendNotificationToUsers(
                    newTitle: titleController.text,
                    newText: bodyController.text,
                    topicName: "news",
                    title: titleController.text,
                    body: bodyController.text,
                  );
                  debugPrint("MESSAGE ID:$messageId");
                  context.read<NotificationViewModel>().addToNotification(
                      NotificationModel(title: titleController.text, id: id));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PushNotificationScreen(),
                    ),
                  );
                }
              },
              child: Text(
                "SEND",
                style: AppTextStyle.recolateMedium.copyWith(
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
