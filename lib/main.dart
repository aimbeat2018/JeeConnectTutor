import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/get_di.dart' as di;
import 'package:jeeconnecttutor/constant/route_helper.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'constant/PushNotificationService.dart';
import 'constant/globalFunction.dart';
import 'controllers/authController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (GlobalFunctions.isMobilePhone()) {
    HttpOverrides.global = MyHttpOverrides();
  }
  await di.init();

  FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);

  runApp(const MyApp());

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestPermission();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      title: 'JeeConnect Tutor',
      supportedLocales: [Locale('en')],
      initialRoute: Get.find<AuthController>().isLoggedIn()
          ? RouteHelper.getMainScreenRoute()
          : RouteHelper.getLoginRoute(),
      getPages: RouteHelper.routes,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
