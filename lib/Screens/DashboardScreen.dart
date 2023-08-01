import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:polo_rules_test/Utils/AppConstents.dart';
import 'package:polo_rules_test/Utils/Colors.dart';
import 'package:polo_rules_test/Utils/dimensions.dart';

import '../Firebase/FirebaseDatabaseHelper.dart';
import '../Objects/AppSettingsObject.dart';
import '../Objects/CategoryObject.dart';
import '../Utils/Images.dart';
import '../Utils/Router.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late double screenWidth;
  late double screenHeight;

  late bool web;

  List<CategoryObject> _categories = [];
  Future<void> _getCategories() async {
    await FirebaseDatabaseHelper().getCategories().then((categoriesData) {
      setState(() {
        _categories = categoriesData;
      });
    });
  }

  AppSettingsObject? _appSettings;

  Future<void> getAppSettings() async {
    await FirebaseDatabaseHelper().getAppSettings().then((settingsData) {
      if (settingsData != null) {
        setState(() {
          _appSettings = settingsData;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
    getAppSettings();
  }

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
      width: screenWidth,
      height: screenHeight,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
      ),
      child: Column(
        children: [
          _topView(),
          _categoriesView(),
        ],
      ),
    );
  }

  Widget _categoriesView() {
    return Expanded(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 10,
              spacing: 40,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: _categories
                  .map(
                    (singleCategory) =>
                        _singleCategoryView(category: singleCategory),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _singleCategoryView({required CategoryObject category}) {
    double boxWidth = web ? screenWidth / 2.5 : screenWidth;
    double boxHeight = web ? boxWidth / 2.4 : boxWidth / 3.4;
    return GestureDetector(
      onTap: () => RouterClass().questionsScreen(
        context: context,
        category: category,
      ),
      child: Container(
        width: boxWidth,
        height: web ? boxHeight + 100 : boxHeight + 50,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          // color: AppThemeColor.pureWhiteColor,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: boxWidth,
              height: boxHeight,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(web ? 25 : 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: category.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppThemeColor.cardBackGroundColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: AppThemeColor.pureWhiteColor,
                      size: web ? 54 : 34,
                    ),
                  ),
                  Text(
                    '${category.title}',
                    style: TextStyle(
                      color: AppThemeColor.pureWhiteColor,
                      fontSize: web ? 25 : Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: boxWidth,
              height: web ? boxHeight + 100 : boxHeight + 50,
              alignment: Alignment.topRight,
              child: Image.network(
                category.imageLink!,
                width: web ? boxWidth / 3.0 : boxWidth / 3.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topView() {
    return SizedBox(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Polo Rules Test (HPA)',
                style: TextStyle(
                  color: AppThemeColor.darkBlueColor,
                  fontWeight: FontWeight.w700,
                  fontSize: web ? 46 : 23,
                ),
              ),
              Container(
                width: web ? screenWidth - 284 : screenWidth - 62,
                child: Text(
                  'The easiest and most comprehensive way to learn the HPA polo rules. Useful for beginners all the way up to advanced players and umpires',
                  style: TextStyle(
                    color: AppThemeColor.dullFontColor,
                    fontWeight: FontWeight.w500,
                    fontSize: web ? 30 : Dimensions.fontSizeSmall,
                  ),
                ),
              ),
            ],
          ),
          if (kIsWeb)
            Column(
              children: [
                InkWell(
                  onTap: () {
                    if (_appSettings != null) {
                      AppConstents()
                          .launchURL(url: _appSettings!.androidAppLink!);
                    }
                  },
                  child: Image.asset(
                    Images.androidAppLogo,
                    width: 190,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_appSettings != null) {
                      AppConstents().launchURL(url: _appSettings!.iosAppLink!);
                    }
                  },
                  child: Image.asset(
                    Images.iosAppLogo,
                    width: 190,
                  ),
                ),
              ],
            ),
          InkWell(
            onTap: () => RouterClass().settingsScreen(context: context),
            child: Icon(
              Icons.settings,
              color: AppThemeColor.darkBlueColor,
              size: web ? 44 : 22,
            ),
          ),
        ],
      ),
    );
  }
}
