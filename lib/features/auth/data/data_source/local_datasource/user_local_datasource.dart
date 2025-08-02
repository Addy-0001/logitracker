import 'package:logitracker/features/auth/domain/entity/user_entity.dart';
import '../../../../../core/database/hive_service.dart';
import '../../model/user_hive_model.dart';

class UserLocalDataSource {
  Future<void> saveUser(UserEntity user) async {
    final box = HiveService.getUserBox();
    await box.put(
      user.email,
      UserHiveModel(
        userId: user.userId,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        password: user.password,
        company: user.company,
        phone: user.phone,
        position: user.position,
        avatar: user.avatar,
        industry: user.industry,
        size: user.size,
        website: user.website,
        address: user.address,
        preferences: user.preferences,
        role: user.role,
      ),
    );
  }

  Future<UserEntity?> getUser(String email) async {
    final box = HiveService.getUserBox();
    final userHive = await box.get(email);
    if (userHive == null) return null;
    return UserEntity(
      userId: userHive.userId,
      firstName: userHive.firstName,
      lastName: userHive.lastName,
      email: userHive.email,
      password: userHive.password,
      company: userHive.company,
      phone: userHive.phone,
      position: userHive.position,
      avatar: userHive.avatar,
      industry: userHive.industry,
      size: userHive.size,
      website: userHive.website,
      address: userHive.address,
      preferences: userHive.preferences,
      role: userHive.role,
    );
  }
}
