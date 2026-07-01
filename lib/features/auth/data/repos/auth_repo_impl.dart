import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/error/failure.dart';
import 'package:tharad_task/core/storage/secure_storage_helper.dart';
import 'package:tharad_task/core/utils/failure_collect.dart';
import 'package:tharad_task/features/auth/data/remote_datasources/auth_remote_datasource.dart';
import 'package:tharad_task/features/auth/domain/entities/auth_entity.dart';
import 'package:tharad_task/features/auth/domain/repos/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;
  final SecureStorageHelper _secureStorage;
  AuthRepositoryImpl(this._dataSource,this._secureStorage);
  

  @override
  Future<Either<Failure, AuthEntity>> register({
    required String email,
    required String username,
    required String password,
    required String passwordConfirmation,
    required String imagePath,
  }) =>
      failureCollect(
        () async => Right(
          await _dataSource.register(
            email: email,
            username: username,
            password: password,
            passwordConfirmation: passwordConfirmation,
            imagePath: imagePath,
          ),
        ),
      );

  @override
  Future<Either<Failure, void>> verifyOtp({
    required String email,
    required String otp,
  }) =>
      failureCollect(
        () async {
          await _dataSource.verifyOtp(email: email, otp: otp);
          return const Right(null);
        },
      );

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  }) =>
      failureCollect(
        () async {
          final entity = await _dataSource.login(
            email: email,
            password: password,
          );
          await _secureStorage.saveTokens(accessToken: entity.token!);
          return Right(entity);
        },
      );
      @override
Future<Either<Failure, void>> logout() async {
  try {
    await _dataSource.logout();
  } catch (_) {
   
  } finally {
    await _secureStorage.clearTokens();
  }
  return const Right(null);
}
}