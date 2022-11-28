import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:libgloss/config/routes.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';
import 'package:libgloss/widgets/animations/slide_route.dart';

import 'config/blocs.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  // Run the initialization splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Run the app
  runApp(BlocSettings.getBlocProviders(Libgloss()));
  FlutterNativeSplash.remove();
}

class Libgloss extends StatefulWidget {
  const Libgloss({super.key});

  @override
  State<Libgloss> createState() => _LibglossState();
}

class _LibglossState extends State<Libgloss> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> saveUserToken() async {
    var myToken = await messaging.getToken();
    if (UserAuthRepository().isAuthenticated()) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserAuthRepository().getuid())
          .update({'token': myToken});
    }
  }

  @override
  void initState() {
    super.initState();
    saveUserToken();

    final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(android: androidSetting);

    _localNotificationsPlugin.initialize(initSettings).then((_) {
      debugPrint('[Notifications] setupPlugin: setup success');
    }).catchError((Object error) {
      debugPrint('[Notifications] Error: $error');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('[Notifications] Message on Foreground: ${message.toString()}');

        _localNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'channel id',
              'channel name',
              channelDescription: 'channel description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker',
              styleInformation: BigTextStyleInformation(''),
              largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
              playSound: true,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LibglossRoutes.getRoute(LibglossRoutes.HOME),
      onGenerateRoute: (settings) {
        return SlideRoute(
          page: LibglossRoutes.getRoutes()[settings.name]!(context),
          settings: settings,
        );
      },
    );
  }
}
