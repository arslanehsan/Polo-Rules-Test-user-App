import 'package:url_launcher/url_launcher.dart';

class AppConstents {
  static const String appName = 'Polo Rules Test';
  static const String appVersion = '1.0.0';
  static const double webSize = 500.0;

  static const List<String> answersOptions = [
    'ansA',
    'ansB',
    'ansC',
    'ansD',
  ];

  Future<void> launchURL({required String url}) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
