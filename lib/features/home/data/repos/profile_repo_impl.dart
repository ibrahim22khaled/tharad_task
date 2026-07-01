import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/error/failure.dart';
import 'package:tharad_task/core/utils/failure_collect.dart';
import 'package:tharad_task/features/home/data/datasources/profile_local_datasource.dart';
import 'package:tharad_task/features/home/data/datasources/profile_remote_datasource.dart';
import 'package:tharad_task/features/home/data/models/profile_model.dart';
import 'package:tharad_task/features/home/domain/entities/profile_entity.dart';
import 'package:tharad_task/features/home/domain/repos/profile_repo.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _dataSource;
  final ProfileLocalDataSource _localDataSource;

  ProfileRepositoryImpl(this._dataSource, this._localDataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    final remoteResult = await failureCollect(
      () async => Right<Failure, ProfileModel>(await _dataSource.getProfile()),
    );

    if (remoteResult.isRight()) {
      final profile = remoteResult.getOrElse(
        () => throw StateError('unreachable'),
      );
      await _localDataSource.cacheProfile(profile);
      return Right(profile);
    }

    final cached = _localDataSource.getCachedProfile();
    if (cached != null) {
      return Right(cached);
    }

    return remoteResult;
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String username,
    required String email,
    String? password,
    String? newPassword,
    String? newPasswordConfirmation,
    String? imagePath,
  }) => failureCollect(() async {
    final updated = await _dataSource.updateProfile(
      username: username,
      email: email,
      password: password,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
      imagePath: imagePath,
    );
    await _localDataSource.cacheProfile(updated);
    return Right(updated);
  });
}
