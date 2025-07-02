import 'package:flutter/material.dart';
import 'package:logitracker/app/app.dart';
import 'app/constant/hive_service.dart';
import 'app/service_locator/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  // Hive.registerAdapter(UserHiveModelAdapter());
  // Hive.registerAdapter(JobHiveModelAdapter());
  setupServiceLocator();
  runApp(const App());
}
