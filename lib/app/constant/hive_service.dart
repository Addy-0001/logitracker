import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String userBox = 'userBox';
  static const String jobBox = 'jobBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(userBox);
    await Hive.openBox(jobBox);
  }

  static Box getUserBox() => Hive.box(userBox);
  static Box getJobBox() => Hive.box(jobBox);
}
