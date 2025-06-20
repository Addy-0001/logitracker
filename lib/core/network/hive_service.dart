export '../../app/constant/hive_service.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:logitracker/app/constant/hive_table_constant.dart';
// import 'package:logitracker/features/auth/data/model/user_hive_model.dart';

// class HiveService {
//   Future<void> init() async {
//     // Initialize the database
//     var directory = await getApplicationDocumentsDirectory();
//     var path = '${directory.path}user_management.db';

//     Hive.init(path);

//     // Register Adapters
//     Hive.registerAdapter(UserHiveModelAdapter());
//   }

//   // Auth Queries
//   Future<void> register(UserHiveModel auth) async {
//     var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
//     await box.put(auth.userId, auth);
//   }

//   Future<void> deleteAuth(String id) async {
//     var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
//     await box.delete(id);
//   }

//   Future<List<UserHiveModel>> getAllAuth() async {
//     var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
//     return box.values.toList();
//   }

//   // Login using username and password
//   Future<UserHiveModel?> login(String username, String password) async {
//     var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
//     var user = box.values.firstWhere(
//       (element) => element.email == username && element.password == password,
//       orElse: () => throw Exception('Invalid username or password'),
//     );
//     box.close();
//     return user;
//   }

//   // Clear all data and delete database
//   Future<void> clearAll() async {
//     await Hive.deleteFromDisk();
//     await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
//   }

//   Future<void> close() async {
//     await Hive.close();
//   }
// }
