import 'package:dartz/dartz.dart';
import 'package:tharad_task/core/error/failure.dart';
import 'package:tharad_task/features/home/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();

  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String username,
    required String email,
    String? password,
    String? newPassword,
    String? newPasswordConfirmation,
    String? imagePath,
  });
}