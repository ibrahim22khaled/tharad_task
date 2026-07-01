import 'package:tharad_task/features/home/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({super.id, super.username, super.email, super.image});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    return ProfileModel(
      id: data?['id'],
      username: data?['username'],
      email: data?['email'],
      image: data?['image'],
    );
  }
}
