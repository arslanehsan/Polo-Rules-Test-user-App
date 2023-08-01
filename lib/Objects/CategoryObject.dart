import 'dart:ui';

class CategoryObject {
  String? id, title;
  String? imageLink;
  Color backgroundColor;

  CategoryObject({
    this.id,
    required this.title,
    this.imageLink,
    required this.backgroundColor,
  });

  factory CategoryObject.fromJson(Map<dynamic, dynamic> json) {
    print('CategoryObject DATA GETTING $json');
    return CategoryObject(
      id: json['id'],
      title: json['title'] ?? '',
      imageLink: json['imageLink'] ?? '',
      backgroundColor: json['backgroundColor'] != null
          ? Color(int.parse(json['backgroundColor'].toString()))
          : const Color(0xff000000),
    );
  }

  Map<dynamic, dynamic> toJson({required String bannerId}) {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['id'] = bannerId;
    data['title'] = title;
    data['imageLink'] = imageLink;

    data['backgroundColor'] = backgroundColor!.value.toString();
    return data;
  }
}
