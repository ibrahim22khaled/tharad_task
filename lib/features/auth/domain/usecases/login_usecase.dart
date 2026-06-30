import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/utils/use_case.dart';
import 'package:tharad_task/core/error/failure.dart';
import 'package:tharad_task/features/auth/domain/entities/auth_entity.dart';
import 'package:tharad_task/features/auth/domain/repos/auth_repository.dart';

@lazySingleton
class LoginUseCase extends UseCase<AuthEntity, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(LoginParams params) {
    return repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}