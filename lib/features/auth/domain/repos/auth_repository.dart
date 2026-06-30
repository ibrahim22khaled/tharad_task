import 'package:dartz/dartz.dart';
import 'package:tharad_task/core/error/failure.dart';
import 'package:tharad_task/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> register({
    required String email,
    required String username,
    required String password,
    required String passwordConfirmation,
    required String imagePath,
  });

  Future<Either<Failure, void>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  });
}