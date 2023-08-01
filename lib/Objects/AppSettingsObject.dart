class AppSettingsObject {
  String? appTitle,
      appVersion,
      privacyPolicyLink,
      aboutUsLink,
      iosAppLink,
      androidAppLink;
  String? inAppIconLink;

  AppSettingsObject({
    this.appTitle,
    this.appVersion,
    this.privacyPolicyLink,
    this.aboutUsLink,
    this.iosAppLink,
    this.androidAppLink,
    this.inAppIconLink,
  });

  factory AppSettingsObject.fromJson(Map<dynamic, dynamic> json) {
    print('AppSettingsObject DATA GETTING $json');
    return AppSettingsObject(
      appTitle: json['appTitle'],
      appVersion: json['appVersion'] ?? '',
      privacyPolicyLink: json['privacyPolicyLink'] ?? '',
      androidAppLink: json['androidAppLink'] ?? '',
      iosAppLink: json['iosAppLink'] ?? '',
      aboutUsLink: json['aboutUsLink'] ?? '',
      inAppIconLink: json['inAppIconLink'] ?? '',
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['appTitle'] = appTitle;
    data['appVersion'] = appVersion;
    data['privacyPolicyLink'] = privacyPolicyLink;
    data['androidAppLink'] = androidAppLink;
    data['iosAppLink'] = iosAppLink;
    data['aboutUsLink'] = aboutUsLink;

    data['inAppIconLink'] = inAppIconLink;
    return data;
  }
}
