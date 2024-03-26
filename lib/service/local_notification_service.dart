import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meal_mate/screens/tab_box/profile/local_notif_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../utils/tools/file_importer.dart';

class LocalNotificationService {
  static final LocalNotificationService localNotificationService =
      LocalNotificationService._();

  factory LocalNotificationService() {
    return localNotificationService;
  }

  LocalNotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void init(GlobalKey<NavigatorState> navigatorKey) async {
    // Android
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("app_icon");

    //IOS
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    InitializationSettings initializationSettings = InitializationSettings(
        iOS: initializationSettingsDarwin,
        android: androidInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notification) {
      if (notification.payload != null) {
        Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) {
              return LocalNotifScreen();
            },
          ),
        );
      }
      print(notification.payload);
    });

    final bool? result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    tz.initializeTimeZones();
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    print("TAPPED FROM BACKGROUND");
  }

  AndroidNotificationChannel androidNotificationChannel =
      const AndroidNotificationChannel(
    "my_channel",
    "Notification Lesson ",
    importance: Importance.max,
    description: "My Notification description",
  );

  //IOS
  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    print(payload);
  }

  void showNotification({
    required NotificationModel notificationModel,
    required String body,

  }) {
    flutterLocalNotificationsPlugin.show(
        notificationModel.id,
        notificationModel.title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails(
              androidNotificationChannel.id,
              androidNotificationChannel.name,
              priority: Priority.max,
              playSound: true,
              icon: "app_icon",
              showProgress: true,
              largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
            ),
            iOS: DarwinNotificationDetails(
              subtitle: notificationModel.title,
              presentAlert: true,
              presentSound: true,
              interruptionLevel: InterruptionLevel.active,
            )),
        payload: "news_screen");
    debugPrint("CURRENT NOTIFICATION ID:${notificationModel.id}");
  }

  void scheduleNotification({
    required String title,
    required String body,
    required int delayedTime,
  }) {
    int id = DateTime.now().millisecond;

    // print("TIME ${DateTime.now()}");
    tz.TZDateTime tzDateTime = tz.TZDateTime.now(tz.local)
        .add(Duration(seconds: 5 * 60 * 60 + delayedTime + 5));
    // print(tzDateTime.toString());
    flutterLocalNotificationsPlugin.zonedSchedule(
      123764,
      title,
      body,
      tzDateTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          priority: Priority.max,
          playSound: true,
          icon: "app_icon",
          showProgress: true,
          largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
        ),
      ),
      payload: "SCHEADULED NOTIFICATION PAYLOAD DATA ID:$id",
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void showPeriodicNotification({
    required String title,
    required String body,
  }) {
    flutterLocalNotificationsPlugin.periodicallyShow(
      2,
      title,
      body,
      RepeatInterval.everyMinute,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          priority: Priority.max,
          playSound: true,
          icon: "app_icon",
          showProgress: true,
          largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
        ),
      ),
    );
  }

  cancelNotification(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }

  cancelAll() {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}
