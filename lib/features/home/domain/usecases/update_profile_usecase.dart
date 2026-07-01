import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/utils/use_case.dart';
import 'package:tharad_task/core/error/failure.dart';
import 'package:tharad_task/features/home/domain/entities/profile_entity.dart';
import 'package:tharad_task/features/home/domain/repos/profile_repo.dart';

@lazySingleton
class UpdateProfileUseCase extends UseCase<ProfileEntity, UpdateProfileParams> {
  final ProfileRepository repository;
  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(UpdateProfileParams params) {
    return repository.updateProfile(
      username: params.username,
      email: params.email,
      password: params.password,
      newPassword: params.newPassword,
      newPasswordConfirmation: params.newPasswordConfirmation,
      imagePath: params.imagePath,
    );
  }
}

class UpdateProfileParams extends Equatable {
  final String username;
  final String email;
  final String? password;
  final String? newPassword;
  final String? newPasswordConfirmation;
  final String? imagePath;

  const UpdateProfileParams({
    required this.username,
    required this.email,
    this.password,
    this.newPassword,
    this.newPasswordConfirmation,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
    username,
    email,
    password,
    newPassword,
    newPasswordConfirmation,
    imagePath,
  ];
}
