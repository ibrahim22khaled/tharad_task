import 'package:tharad_task/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    super.email,
    super.username,
    required super.token,
    super.image,
    super.otp,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    return AuthModel(
      email: data?['email'],
      username: data?['username'],
      token: data?['token'],
      image: data?['image'],
      otp: data?['otp']?.toString(),
    );
  }
}
