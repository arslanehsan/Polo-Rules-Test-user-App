import 'dart:async';

import 'package:flutter/material.dart';

import '../Utils/Colors.dart';
import '../Utils/Images.dart';
import '../Utils/Router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double screenWidth = 1000;
  double screenHeight = 1000;

  late AnimationController logoAnimation;

  _handleAnimation() {
    logoAnimation = AnimationController(
      upperBound: 300,
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    logoAnimation.forward();
    logoAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    _handleAnimation();
    Timer(const Duration(seconds: 3), () {
      RouterClass().dashboardScreen(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: screenWidth,
      height: screenHeight,
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Polo Rules',
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w700,
                    color: AppThemeColor.darkBlueColor,
                  ),
                ),
                Text(
                  'Test',
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w700,
                    color: AppThemeColor.darkBlueColor,
                  ),
                ),
              ],
            ),
            Image.asset(
              Images.inAppLogo,
              width: logoAnimation.value,
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
