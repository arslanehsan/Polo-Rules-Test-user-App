import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polo_rules_test/Screens/SplashScreen.dart';
import 'package:url_strategy/url_strategy.dart';

import 'Utils/Colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAxBtdb670gl64yANbskeJCmjtOc3rJGUc",
        appId: "1:29763040997:web:b581a373cf412e5c69c60c",
        storageBucket: "polo-rules.appspot.com",
        authDomain: "polo-rules.firebaseapp.com",
        databaseURL: "https://polo-rules-default-rtdb.firebaseio.com",
        messagingSenderId: "29763040997",
        projectId: "polo-rules",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark, // For iOS: (dark icons)
      statusBarIconBrightness: Brightness.dark, // For Android: (dark icons)
      statusBarColor: AppThemeColor.backGroundColor, // status bar color
      systemNavigationBarColor:
          AppThemeColor.backGroundColor, // navigation bar color
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Polo Rules Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: AppThemeColor.darkBlueColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
