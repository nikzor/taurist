import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/authorization_controller.dart';
import 'package:taurist/screens/forgotPassword/main_screen.dart';
import 'package:taurist/screens/signIn/main_screen.dart';
import 'package:taurist/screens/start/main_screen.dart';
import 'package:taurist/screens/mainScreen/main_screen.dart';
import 'package:taurist/screens/signUp/main_screen.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthorizationController()));
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white70),
      initialRoute: AuthorizationController.instance.auth.currentUser==null ? '/startPage' : '/routes',
      getPages: [
        GetPage(name: '/startPage', page: ()=>const StartPage()),
        GetPage(name: '/signInPage', page: ()=>const SignInPage()),
        GetPage(name: '/signUpPage', page: ()=>const SignUpPage()),
        GetPage(name: '/forgotPasswordPage', page: ()=>const ForgotPasswordPage()),
        GetPage(name: '/routes', page: ()=>const RoutesPage()),
      ],
    ),
  );
}
