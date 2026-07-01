import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/utils/use_case.dart';
import 'package:tharad_task/core/error/failure.dart';
import 'package:tharad_task/features/home/domain/entities/profile_entity.dart';
import 'package:tharad_task/features/home/domain/repos/profile_repo.dart';

@lazySingleton
class GetProfileUseCase extends UseCase<ProfileEntity, NoParams> {
  final ProfileRepository repository;
  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) {
    return repository.getProfile();
  }
}
