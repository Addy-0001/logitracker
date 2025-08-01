import 'package:hive_flutter/hive_flutter.dart';
import 'package:logitracker/features/auth/data/model/user_hive_model.dart';
import 'package:logitracker/features/job/data/model/job_hive_model.dart';

class HiveService {
  static const String userBox = 'userBox';
  static const String jobBox = 'jobBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserHiveModelAdapter());
    Hive.registerAdapter(JobHiveModelAdapter());
    await Hive.openBox<UserHiveModel>(userBox);
    await Hive.openBox<JobHiveModel>(jobBox);
  }

  static Box<UserHiveModel> getUserBox() => Hive.box<UserHiveModel>(userBox);
  static Box<JobHiveModel> getJobBox() => Hive.box<JobHiveModel>(jobBox);
}
