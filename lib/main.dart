import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/authorization_controller.dart';
import 'package:taurist/routes.dart';
import 'package:taurist/screens/forgotPassword/main_screen.dart';
import 'package:taurist/screens/newRouteScreen/main_screen.dart';
import 'package:taurist/screens/profileScreen/main_screen.dart';
import 'package:taurist/screens/profileSettings/main_screen.dart';
import 'package:taurist/screens/routesDescScreen/main_screen.dart';
import 'package:taurist/screens/routesScreen/main_screen.dart';
import 'package:taurist/screens/signIn/main_screen.dart';
import 'package:taurist/screens/signUp/main_screen.dart';
import 'package:taurist/screens/start/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp()
        .then((value) => Get.put(AuthorizationController()));
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDkAx_7BpwBcljaKaN8SLBTwwMZVJqDMIs",
        authDomain: "tauristapp-74b3f.firebaseapp.com",
        projectId: "tauristapp-74b3f",
        storageBucket: "tauristapp-74b3f.appspot.com",
        messagingSenderId: "1091313771929",
        appId: "1:1091313771929:web:ca39a90ef44b0f02a19f08",
        measurementId: "G-RWMW81901P",
      ),
    ).then((value) => Get.put(AuthorizationController()));
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white70),
      initialRoute: AuthorizationController.instance.auth.currentUser == null
          ? Routes.startPage
          : Routes.routesPage,
      getPages: [
        GetPage(name: Routes.startPage, page: () => const StartPage()),
        GetPage(name: Routes.signInPage, page: () => const SignInPage()),
        GetPage(name: Routes.signUpPage, page: () => const SignUpPage()),
        GetPage(
            name: Routes.forgotPasswordPage,
            page: () => const ForgotPasswordPage()),
        GetPage(name: Routes.routesPage, page: () => const RoutesPage()),
        GetPage(name: Routes.routeDescPage, page: () => RoutesDescPage()),
        GetPage(
            name: Routes.newRouteScreen, page: () => const NewRouteScreen()),
        GetPage(name: Routes.profilePage, page: () => const ProfilePage()),
        GetPage(
            name: Routes.profileSettingsPage,
            page: () => const ProfileSettings()),
      ],
    ),
  );
}
