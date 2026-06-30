import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/utils/async.dart';
import 'package:tharad_task/features/auth/domain/usecases/register_usecase.dart';
import 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(const Async.initial());

  // Save email to send it to otp screen 
  String? registeredEmail;

  Future<void> register({
    required String email,
    required String username,
    required String password,
    required String passwordConfirmation,
    required String imagePath,
  }) async {
    emit(const Async.loading());

    final result = await _registerUseCase(
      RegisterParams(
        email: email,
        username: username,
        password: password,
        passwordConfirmation: passwordConfirmation,
        imagePath: imagePath,
      ),
    );

    result.fold(
      (failure) => emit(Async.failure(failure)),
      (entity) {
        registeredEmail = entity.email;
        emit(Async.success(entity));
      },
    );
  }
}