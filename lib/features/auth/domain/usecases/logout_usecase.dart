import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/utils/use_case.dart';
import 'package:tharad_task/core/error/failure.dart';
import 'package:tharad_task/features/auth/domain/repos/auth_repository.dart';

@lazySingleton
class LogoutUseCase extends UseCase<void, NoParams> {
  final AuthRepository repository;
  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.logout();
  }
}