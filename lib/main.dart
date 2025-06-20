import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logitracker/app/app.dart';
import 'app/constant/hive_service.dart';
import 'app/service_locator/service_locator.dart';
import 'features/auth/data/model/user_hive_model.dart';
import 'features/delivery/data/model/job_hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  Hive.registerAdapter(UserHiveModelAdapter());
  Hive.registerAdapter(JobHiveModelAdapter());
  setupServiceLocator();
  runApp(const App());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Logitracker',
//       theme: getApplicationTheme(),
//       initialRoute: '/splash',
//       routes: {
//         '/splash': (context) => const SplashView(),
//         '/login': (context) => const LoginView(),
//         '/register': (context) => const RegisterView(),
//         '/home': (context) => const HomeView(),
//       },
//     );
//   }
// }
