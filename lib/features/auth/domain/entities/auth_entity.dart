import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? email;
  final String? username;
  final String? token;
  final String? image;
  final String? otp;

  const AuthEntity({
    this.email,
    this.username,
     this.token,
    this.image,
    this.otp,
  });

  @override
  List<Object?> get props => [email, username, token, image, otp];
}
