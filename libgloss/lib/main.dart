import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:libgloss/config/routes.dart';
import 'package:libgloss/widgets/animations/slide_route.dart';

import 'config/blocs.dart';
import 'notification_controller.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  // Run the initialization splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
  );

  AwesomeNotificationsFcm().initialize(
    onFcmTokenHandle: NotificationController.myFcmTokenHandle,
    onNativeTokenHandle: NotificationController.myNativeTokenHandle,
    onFcmSilentDataHandle: NotificationController.onFcmSilentDataHandle,
  );

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
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);

    super.initState();
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
