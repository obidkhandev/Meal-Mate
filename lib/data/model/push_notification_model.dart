import 'package:flutter/material.dart';

class PushNotificationModel {
  final String? to;
  final NotificationContent notification;
  final NotificationData data;

  PushNotificationModel({
    this.to,
    required this.notification,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'to': to,
      'notification': notification.toJson(),
      'data': data.toJson(),
    };
  }

  factory PushNotificationModel.fromJson(Map<String, dynamic> json) {
    return PushNotificationModel(
      to: json['to'],
      notification: NotificationContent.fromJson(json['notification']),
      data: NotificationData.fromJson(json['data']),
    );
  }

}

class NotificationContent {
  final String title;
  final String body;
  final String sound;
  final String priority;

  NotificationContent({
    required this.title,
    required this.body,
    required this.sound,
    required this.priority,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'sound': sound,
      'priority': priority,
    };
  }

  factory NotificationContent.fromJson(Map<String, dynamic> json) {
    return NotificationContent(
      title: json['title'],
      body: json['body'],
      sound: json['sound'],
      priority: json['priority'],
    );
  }
}

class NotificationData {
  // final String newsImage;
  final String newsTitle;
  final String newsText;

  NotificationData({

    required this.newsTitle,
    required this.newsText,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(newsTitle: json['newsTitle'], newsText: json['newsText']);
  }

  Map<String, dynamic> toJson() {
    return {
      'news_title': newsTitle,
      'news_text': newsText,
    };
  }
}