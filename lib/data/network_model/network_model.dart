import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meal_mate/data/model/push_notification_model.dart';

 const String appToken = "AAAA9U2QiIY:APA91bGVHsraUOGSzi4leEki3QJtxWsYjJTwuVJmPF_ytZE50G8B3SVmyic6nQks3bxgLHtV9hIzMG2b-S0QcJD3d2LBGBqjORo6H2PCypJay5vOjA1o0naj7O8JcygnBRpFCth4u5ZN";

class ApiProvider {
  Future<Object> sendNotificationToUsers({
    String? topicName,
    String? fcmToken,
    required String title,
    required String body,
    required String newTitle,
    required String newText,

  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Authorization":
          "key=$appToken",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          PushNotificationModel(
            to: topicName != null ? "/topics/$topicName" : fcmToken,
            notification: NotificationContent(
              title: title,
              body: body,
              sound: "default",
              priority: "high",
            ),
            data: NotificationData(
              newsTitle: newTitle,
              newsText: newText
            ),
          ),
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        debugPrint("DATA:${response.body}");
        return PushNotificationModel.fromJson(json.decode(response.body));
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    return "ERROR";
  }
}