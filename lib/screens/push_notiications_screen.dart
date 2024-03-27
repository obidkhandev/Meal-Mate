import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meal_mate/data/model/user_model.dart';
import 'package:meal_mate/data/network_model/network_model.dart';
import 'package:meal_mate/screens/tab_box/profile/local_notif_screen.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';


class PushNotificationScreen extends StatefulWidget {
  // final List<UserModel>? allUsers;
  const PushNotificationScreen({Key? key,}) : super(key: key);

  @override
  State<PushNotificationScreen> createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  String fcmToken = "";
  int id = 1;
  bool isSubscribe = true;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    debugPrint("FCM TOKEN:$fcmToken");

    final token = await FirebaseMessaging.instance.getAPNSToken();
    debugPrint("getAPNSToken : ${token.toString()}");



    // Foreground
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

          debugPrint("FOREGROUND NOTIFICATION:${remoteMessage.notification!.title}");
        }
      },
    );

    // Background
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

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  UserModel? activeUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover Any News"),
      ),
      body: context.watch<AuthViewModel>().isLoad? const Center(child: CircularProgressIndicator(),): Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  isSubscribe = !isSubscribe;
                });
                if (!isSubscribe) {
                  FirebaseMessaging.instance.subscribeToTopic("news");
                } else {
                  FirebaseMessaging.instance.unsubscribeFromTopic("news");
                }
              },
              child: Text(
                isSubscribe ? "Unsubscribe" : "Subscribe",
                style: TextStyle(fontSize: 24),
              ),
            ),

            Center(
              child: DropdownButton<UserModel>(
                value: activeUser,
                onChanged: (UserModel? value) {
                  setState(() {
                    activeUser = value;
                  });
                },
                items: context.watch<AuthViewModel>().users?.map<DropdownMenuItem<UserModel>>((UserModel userModel) {
                  return DropdownMenuItem<UserModel>(
                    value: userModel,
                    child: Text(userModel.email), // Assuming UserModel has a property 'email'
                  );
                }).toList() ?? [], // Use an empty list if users is null
              ),
            ),



            Text( context.watch<AuthViewModel>().users!.first.userName),
            SizedBox(height: 30),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Title",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                hintText: "Body",
              ),
            ),

            Spacer(),
            TextButton(
              onPressed: () async {
                Object? messageId;
                if (isSubscribe) {
                  messageId = await ApiProvider().sendNotificationToUsers(
                    fcmToken: activeUser!.fcmToken,
                    newTitle: titleController.text,
                    newText: bodyController.text,
                    title: titleController.text,
                    body: bodyController.text,
                  );
                } else {
                  messageId = await ApiProvider().sendNotificationToUsers(
                    topicName: "news",
                    newTitle: titleController.text,
                    newText: bodyController.text,
                    title: titleController.text,
                    body: bodyController.text,
                  );
                  print("${isSubscribe} Subscribe");
                }

                debugPrint("MESSAGE ID:$messageId");
                Navigator.push(context, MaterialPageRoute(builder: (_)=> LocalNotifScreen()));
                context.read<NotificationViewModel>().addToNotification(
                    NotificationModel(title: titleController.text, id: id));
                id++;
                titleController.clear();
                bodyController.clear();
              },
              child: Text(
                "SEND",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
