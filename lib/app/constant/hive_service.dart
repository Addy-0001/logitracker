import 'package:hive_flutter/hive_flutter.dart';
import 'package:logitracker_mobile_app/app/constant/hive_table_constant.dart';
import 'package:logitracker_mobile_app/features/auth/data/model/user_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserHiveModelAdapter());
    await Hive.openBox(HiveTableConstant.userBox);
  }

  static Box getUserBox() => Hive.box(HiveTableConstant.userBox);
}
