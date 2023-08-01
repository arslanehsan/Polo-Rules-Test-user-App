import 'package:flutter/material.dart';
import 'package:polo_rules_test/Objects/CategoryObject.dart';
import 'package:polo_rules_test/Screens/DashboardScreen.dart';
import 'package:polo_rules_test/Screens/QuizCompleteScreen.dart';
import 'package:polo_rules_test/Screens/SettingsScreen.dart';
import 'package:polo_rules_test/Screens/SingleCategoryView.dart';
import 'package:polo_rules_test/Utils/WebViewPage.dart';

class RouterClass {
  dashboardScreen({required BuildContext context}) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ));

  questionsScreen(
          {required BuildContext context, required CategoryObject category}) =>
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleCategoryView(category: category),
          ));

  restartQuestionsScreen(
          {required BuildContext context, required CategoryObject category}) =>
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SingleCategoryView(category: category),
          ));

  quizCompleteScreen(
          {required BuildContext context, required CategoryObject category}) =>
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizCompleteScreen(category: category),
          ));

  settingsScreen({required BuildContext context}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ));

  webScreen({
    required BuildContext context,
    required String title,
    required String url,
  }) =>
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: url, title: title),
          ));
}
