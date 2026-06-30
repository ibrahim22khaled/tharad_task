import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/utils/use_case.dart';
import 'package:tharad_task/core/error/failure.dart';
import 'package:tharad_task/features/auth/domain/repos/auth_repository.dart';

@lazySingleton
class VerifyOtpUseCase extends UseCase<void, OtpParams> {
  final AuthRepository repository;
  VerifyOtpUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(OtpParams params) {
    return repository.verifyOtp(
      email: params.email,
      otp: params.otp,
    );
  }
}

class OtpParams extends Equatable {
  final String email;
  final String otp;

  const OtpParams({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}