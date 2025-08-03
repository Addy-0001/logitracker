import 'package:hive_flutter/hive_flutter.dart';
// import 'package:logitracker/features/auth/data/model/user_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  Future<void> init() async {
    //Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}logitracker.db';

    Hive.init(path);

    //Register Adapter
    // Hive.registerAdapter(UserHiveModelAdapter());
  }
}
