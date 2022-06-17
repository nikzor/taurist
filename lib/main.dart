import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:taurist/screens/forgot_password_page.dart';
import 'package:taurist/screens/loginpage.dart';
import 'package:taurist/screens/mainscreen.dart';
import 'package:taurist/screens/signup_page.dart';
import 'package:taurist/screens/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(
    MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: Utils.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white70),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/login': (context) => const LoginPage(),
        '/signin': (context) => const SignupPage(),
        '/forgot': (context) => const ForgotPasswordPage(),
      },
    ),
  );
}
