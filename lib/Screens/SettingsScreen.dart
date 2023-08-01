import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:polo_rules_test/Firebase/FirebaseDatabaseHelper.dart';
import 'package:polo_rules_test/Objects/AppSettingsObject.dart';

import '../../Utils/Colors.dart';
import '../../Utils/dimensions.dart';
import '../Utils/AppConstents.dart';
import '../Utils/Images.dart';
import '../Utils/Router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late double screenWidth;
  late double screenHeight;

  late bool web;
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
    getAppSettings();
    super.initState();
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
      height: screenHeight,
      width: screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.close_rounded,
                color: AppThemeColor.darkBlueColor,
                size: web ? 54 : 34,
              ),
            ),
    import 'package:flutter/material.dart';

    class SymptomCheckScreen extends StatefulWidget {
    @override
    _SymptomCheckScreenState createState() => _SymptomCheckScreenState();
    }

    class _SymptomCheckScreenState extends State<SymptomCheckScreen> {
    List<String> selectedSymptoms = [];

    void _toggleSymptom(String symptom) {
    setState(() {
    if (selectedSymptoms.contains(symptom)) {
    selectedSymptoms.remove(symptom);
    } else {
    selectedSymptoms.add(symptom);
    }
    });
    }

    void _checkSymptoms() {
    // Implement your logic to check symptoms here
    // You can use the selectedSymptoms list to determine the result
    // For simplicity, we'll just show a dialog with the selected symptoms
    showDialog(
    context: context,
    builder: (context) {
    return AlertDialog(
    title: Text('Selected Symptoms'),
    content: Text(selectedSymptoms.join(", ")),
    actions: [
    TextButton(
    onPressed: () {
    Navigator.of(context).pop();
    },
    child: Text('Close'),
    ),
    ],
    );
    },
    );
    }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text('Symptom Checker'),
    ),
    body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    Text(
    'Select your symptoms:',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 16),
    _buildSymptomCheckbox('Fever'),
    _buildSymptomCheckbox('Cough'),
    _buildSymptomCheckbox('Headache'),
    _buildSymptomCheckbox('Sore Throat'),
    // Add more symptom checkboxes as needed
    SizedBox(height: 16),
    ElevatedButton(
    onPressed: selectedSymptoms.isEmpty ? null : _checkSymptoms,
    child: Text('Check Symptoms'),
    ),
    ],
    ),
    ),
    );
    }

    Widget _buildSymptomCheckbox(String symptom) {
    return CheckboxListTile(
    title: Text(symptom),
    value: selectedSymptoms.contains(symptom),
    onChanged: (value) {
    _toggleSymptom(symptom);
    },
    );
    }
    }

    _singleValueView(
              title: 'App Name',
              value: AppConstents.appName,
            ),
            const SizedBox(
              height: 20,
            ),
            _singleValueView(
              title: 'App Version',
              value: AppConstents.appVersion,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Divider(
                thickness: 1,
                color: AppThemeColor.darkBlueColor,
                endIndent: web ? screenWidth / 4 : screenWidth / 5,
                indent: web ? screenWidth / 4 : screenWidth / 5,
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (_appSettings != null) {
                      if (kIsWeb) {
                        AppConstents()
                            .launchURL(url: _appSettings!.aboutUsLink!);
                      } else {
                        RouterClass().webScreen(
                          context: context,
                          title: 'About Us',
                          url: _appSettings!.aboutUsLink!,
                        );
                      }
                    }
                  },
                  child: _singleTabView(
                    iconData: Icons.help_outline,
                    title: 'About Us',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_appSettings != null) {
                      if (kIsWeb) {
                        AppConstents()
                            .launchURL(url: _appSettings!.privacyPolicyLink!);
                      } else {
                        RouterClass().webScreen(
                          context: context,
                          title: 'Privacy Policy',
                          url: _appSettings!.privacyPolicyLink!,
                        );
                      }
                    }
                  },
                  child: _singleTabView(
                    iconData: Icons.policy,
                    title: 'Privacy Policy',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleValueView({
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize:
                web ? Dimensions.fontSizeExtraLarge : Dimensions.fontSizeLarge,
            color: AppThemeColor.pureBlackColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize:
                web ? Dimensions.fontSizeExtraLarge : Dimensions.fontSizeLarge,
            color: AppThemeColor.dullFontColor,
          ),
        ),
      ],
    );
  }

  Widget _singleTabView({
    required IconData iconData,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: web ? 44 : 22,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: TextStyle(
                  color: AppThemeColor.pureBlackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: web
                      ? Dimensions.fontSizeExtraLarge
                      : Dimensions.fontSizeLarge,
                ),
              )
            ],
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: AppThemeColor.pureBlackColor,
            size: 28,
          )
        ],
      ),
    );
  }
}
