import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/utils/use_case.dart';
import 'package:tharad_task/core/error/failure.dart';
import 'package:tharad_task/features/auth/domain/entities/auth_entity.dart';
import 'package:tharad_task/features/auth/domain/repos/auth_repository.dart';

@lazySingleton
class RegisterUseCase extends UseCase<AuthEntity, RegisterParams> {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(RegisterParams params) {
    return repository.register(
      email: params.email,
      username: params.username,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
      imagePath: params.imagePath,
    );
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String username;
  final String password;
  final String passwordConfirmation;
  final String imagePath;

  const RegisterParams({
    required this.email,
    required this.username,
    required this.password,
    required this.passwordConfirmation,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [
        email,
        username,
        password,
        passwordConfirmation,
        imagePath,
      ];
}