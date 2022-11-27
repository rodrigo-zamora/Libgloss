import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    print("[Awesome Notifications] onNotificationCreatedMethod");
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    print("[Awesome Notifications] onNotificationDisplayedMethod");
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("[Awesome Notifications] onDismissActionReceivedMethod");
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("[Awesome Notifications] onActionReceivedMethod");
  }

  /// Use this method to detect when a new fcm token is received
  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    debugPrint('[Awesome Notifications] FCM Token:"$token"');

    // Save the token in the database
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserAuthRepository().getuid())
          .update({'token': token});
    } catch (e) {
      print(e);
    }
  }

  /// Use this method to detect when a new native token is received
  @pragma("vm:entry-point")
  static Future<void> myNativeTokenHandle(String token) async {
    debugPrint('[Awesome Notifications] Native Token:"$token"');
  }

  /// Use this method to detect when a new silent data is received
  @pragma("vm:entry-point")
  static Future<void> onFcmSilentDataHandle(data) async {
    debugPrint('[Awesome Notifications] Silent Data:"$data"');
  }
}
