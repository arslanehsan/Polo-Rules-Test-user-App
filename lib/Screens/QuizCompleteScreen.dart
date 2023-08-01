import 'package:flutter/material.dart';
import 'package:polo_rules_test/Objects/CategoryObject.dart';
import 'package:polo_rules_test/Utils/Colors.dart';
import 'package:polo_rules_test/Utils/dimensions.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Router.dart';

class QuizCompleteScreen extends StatefulWidget {
  final CategoryObject category;
  const QuizCompleteScreen({
    super.key,
    required this.category,
  });

  @override
  State<QuizCompleteScreen> createState() => _QuizCompleteScreenState();
}

class _QuizCompleteScreenState extends State<QuizCompleteScreen> {
  late double screenWidth;
  late double screenHeight;
  late bool web;

  late final CategoryObject category = widget.category;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    web = screenWidth > AppConstents.webSize;
    return Scaffold(
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: screenHeight,
      width: screenWidth,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: category.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Quiz Complete!',
            style: TextStyle(
              color: AppThemeColor.pureWhiteColor,
              fontSize: web
                  ? Dimensions.fontSizeExtraLarge * 2
                  : Dimensions.fontSizeExtraLarge,
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            onTap: () => RouterClass().dashboardScreen(context: context),
            child: _singleButtonView(label: 'Go Home'),
          ),
          InkWell(
            onTap: () => RouterClass()
                .restartQuestionsScreen(context: context, category: category),
            child: _singleButtonView(label: 'Restart Quiz'),
          ),
        ],
      ),
    );
  }

  Widget _singleButtonView({required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: web ? 70 : 35,
        vertical: web ? 40 : 20,
      ),
      decoration: BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
        borderRadius: BorderRadius.circular(web ? 20 : 10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: category.backgroundColor,
          fontSize: web
              ? Dimensions.fontSizeExtraLarge * 2
              : Dimensions.fontSizeExtraLarge,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
