import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/constant/hive_service.dart';
import 'app/service_locator/service_locator.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await setupServiceLocator(); // Ensure this is awaited
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
