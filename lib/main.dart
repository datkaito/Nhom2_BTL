import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/local_storage.dart';
import 'package:doan_clean_achitec/shared/services/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'modules/lang/transparent_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  await LocalStorageHelper.initLocalStorageHelper();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ColorConstants.blue,
  ));

  Stripe.publishableKey =
      "pk_test_51OIMAyHdpKm7MB8qqvzh6yB053y1lg8vJlUhPZ05Omb93IrEljTl9pC4YAuay0jh1cvxfQfHAkWMnkiGhfB3l92Y00XANULzRX";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  if (fcmToken != null) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (kDebugMode) {
        print("onMessageOpenedApp: $event");
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    subscribeToBookingTopic();
    LocalStorageHelper.setString('fcmToken', fcmToken);
  } else {
    if (kDebugMode) {
      print('fcmToken is null');
    }
  }
  final handler = NotificationHandler();
  handler.setListeners();

  runApp(MyApp());
}

void subscribeToBookingTopic() async {
  await FirebaseMessaging.instance.subscribeToTopic("topic");
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the message when the app is in the background
  if (kDebugMode) {
    print("onBackgroundMessage: $message");
  }
  // Show a notification or perform other actions as needed
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final mainTheme = ThemeData(
    scaffoldBackgroundColor: ColorConstants.bgrLight,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: Routes.SPLASH,
      defaultTransition: Transition.fade,
      getPages: AppPages.routes,
      smartManagement: SmartManagement.keepFactory,
      title: 'Flutter GetX Clean Travel',
      theme: mainTheme.copyWith(brightness: Brightness.light),
      builder: EasyLoading.init(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..backgroundColor = ColorConstants.lightGray
    ..indicatorColor = hexToColor('#64DEE0')
    ..textColor = hexToColor('#64DEE0')
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
