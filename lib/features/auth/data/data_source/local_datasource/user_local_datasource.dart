import 'package:hive/hive.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';
import 'package:logitracker_mobile_app/features/auth/data/model/user_hive_model.dart';
import 'package:logitracker_mobile_app/app/constant/hive_table_constant.dart';

class UserLocalDataSource {
  Future<void> saveUser(UserHiveModel user) async {
    try {
      final box = await Hive.openBox(HiveTableConstant.userBox);
      await box.put('current_user', user.toJson());
    } catch (e) {
      throw CacheFailure('Failed to save user: $e');
    }
  }

  Future<UserHiveModel?> getUser() async {
    try {
      final box = await Hive.openBox(HiveTableConstant.userBox);
      final userJson = box.get('current_user');
      if (userJson != null) {
        return UserHiveModel.fromJson(userJson);
      }
      return null;
    } catch (e) {
      throw CacheFailure('Failed to retrieve user: $e');
    }
  }

  Future<String?> getToken() async {
    try {
      final user = await getUser();
      return user?.token;
    } catch (e) {
      throw CacheFailure('Failed to retrieve token: $e');
    }
  }

  Future<void> clearUser() async {
    try {
      final box = await Hive.openBox(HiveTableConstant.userBox);
      await box.delete('current_user');
    } catch (e) {
      throw CacheFailure('Failed to clear user: $e');
    }
  }
}
