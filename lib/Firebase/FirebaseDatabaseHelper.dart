import 'package:firebase_database/firebase_database.dart';

import '../Objects/AppSettingsObject.dart';
import '../Objects/CategoryObject.dart';
import '../Objects/QuestionObject.dart';

class FirebaseDatabaseHelper {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  Future<AppSettingsObject?> getAppSettings() async {
    AppSettingsObject? appSettings;

    final topUserPostsRef = FirebaseDatabase.instance.ref('AppSettings');
    try {
      await topUserPostsRef.once().then((snapshot) {
        Map<dynamic, dynamic>? value =
            snapshot.snapshot.value as Map<dynamic, dynamic>?;
        if (value != null) {
          appSettings = AppSettingsObject.fromJson(value);
        }
      });

      return appSettings;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Categories
  Future<List<CategoryObject>> getCategories() async {
    List<CategoryObject> categoriesData = [];
    DatabaseReference dbf = firebaseDatabase.ref().child('Categories');

    await dbf.once().then((snapshot) {
      Map<dynamic, dynamic>? value =
          snapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (value != null) {
        value.forEach((key, values) {
          CategoryObject category = CategoryObject.fromJson(values);

          categoriesData.add(category);
        });
      }
    });
    return categoriesData;
    // ..sort((a, b) => a.brandSequence.compareTo(b.brandSequence));
  }

  Future<List<QuestionObject>> getQuestions(
      {required String categoryId}) async {
    List<QuestionObject> questionsData = [];

    final dbf = firebaseDatabase
        .ref()
        .child('Questions')
        .orderByChild('questionCategory')
        .equalTo(
          categoryId,
        );

    await dbf.once().then((snapshot) {
      Map<dynamic, dynamic>? value =
          snapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (value != null) {
        value.forEach((key, singleValue) {
          questionsData.add(QuestionObject.fromJson(singleValue));
        });
      }
    });
    return questionsData;
    // ..sort((a, b) => b.orderTime!.compareTo(a.orderTime!));
  }
}
