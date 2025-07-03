import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logitracker_mobile_app/app/constant/hive_table_constant.dart';
import 'package:logitracker_mobile_app/app/app.dart';
import 'package:logitracker_mobile_app/app/service_locator/service_locator.dart';
import 'package:logitracker_mobile_app/features/auth/data/model/user_hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserHiveModelAdapter());
  await Hive.openBox(HiveTableConstant.userBox);
  setup();
  runApp(App());
}
