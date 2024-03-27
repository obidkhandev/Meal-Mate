import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meal_mate/data/model/push_notification_model.dart';

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
          "key=AAAA9U2QiIY:APA91bFixAwqVHJyu-Zah-_ZfhKWT9gs1mlPLSwUydA70kNoDTudip698aW-CyD9L6o7Vj0LckbocCGQ2-GaA1ssuBC9qu5aA66VSgM3Cwtw5w07rAMQ1lCTK-o-und29vahJiQrX_o7",
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