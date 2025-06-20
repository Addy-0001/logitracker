import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_hive_model.g.dart';


class UserHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String password;
  @HiveField(5)
  final String company;
  @HiveField(6)
  final String phone;
  @HiveField(7)
  final String position;
  @HiveField(8)
  final String avatar;
  @HiveField(9)
  final String industry;
  @HiveField(10)
  final String size;
  @HiveField(11)
  final String website;
  @HiveField(12)
  final String address;
  @HiveField(13)
  final String preferences;
  @HiveField(14)
  final String role = "driver";

  const UserHiveModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.company,
    required this.phone,
    required this.position,
    required this.avatar,
    required this.industry,
    required this.size,
    required this.website,
    required this.address,
    required this.preferences,
  });

  const UserHiveModel.initial()
    : userId = "",
      firstName = "",
      lastName = "",
      email = "",
      password = "",
      company = "",
      phone = "",
      position = "",
      avatar = "",
      industry = "",
      size = "",
      website = "",
      address = "",
      preferences = "";

  @override
  //implement props
  List<Object?> get props => [
    userId, 
    firstName, 
    lastName, 
    email, 
    password, 
    company, 
    phone, 
    position, 
    avatar, 
    industry, 
    size, 
    website, 
    address,
    preferences,
    
  ];
}
