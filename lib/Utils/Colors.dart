import 'package:flutter/cupertino.dart';

class AppThemeColor {
  static const Color dullWhiteColor = Color(0xFFE5E5E5);
  static const Color pureWhiteColor = Color(0xFFFFFFFF);
  static const Color pureBlackColor = Color(0xFF000000);
  static const Color darkBlueColor = Color(0xFF16243E);
  static const Color transparentBlueColor = Color(0x9416243E);
  static const Color orangeColor = Color(0xFFFD9512);
  static const Color yellowColor = Color(0xFFF2C447);
  static const Color greenColor = Color(0xFF85A93F);
  static const Color dullBlueColor = Color(0xFF73ABE4);
  static const Color lightBlueColor = Color(0xFFF3F8FC);
  static const Color dullFontColor = Color(0xFF646060);

  static const Color backGroundColor = Color(0xFFFFFFFF);
  static const Color cardBackGroundColor = Color(0x90cddbea);
  static const Color grayColor = Color(0xFF60676C);
  static const Color lightGrayColor = Color(0x60B8BBBE);

  static const Gradient backgroundGradient1 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.8, 1),
    colors: <Color>[
      darkBlueColor,
      pureWhiteColor,
    ], // Gradient from https://learnui.design/tools/gradient-generator.html
    tileMode: TileMode.mirror,
  );

  static const Gradient backgroundGradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.8, 1),
    colors: <Color>[
      Color(0x80FFFFFF),
      Color(0x67FFFFFF),
    ], // Gradient from https://learnui.design/tools/gradient-generator.html
    tileMode: TileMode.mirror,
  );
}
