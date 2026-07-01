import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final int? id;
  final String? username;
  final String? email;
  final String? image;

  const ProfileEntity({
    this.id,
    this.username,
    this.email,
    this.image,
  });

  @override
  List<Object?> get props => [id, username, email, image];
}