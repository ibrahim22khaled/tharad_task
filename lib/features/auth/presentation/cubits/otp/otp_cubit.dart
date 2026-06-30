import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/utils/async.dart';
import 'package:tharad_task/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'otp_state.dart';

@injectable
class OtpCubit extends Cubit<OtpState> {
  final VerifyOtpUseCase _verifyOtpUseCase;

  OtpCubit(this._verifyOtpUseCase) : super(const Async.initial());

  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    emit(const Async.loading());

    final result = await _verifyOtpUseCase(
      OtpParams(email: email, otp: otp),
    );

    result.fold(
      (failure) => emit(Async.failure(failure)),
      (_) => emit(const Async.successWithoutData()),
    );
  }
}