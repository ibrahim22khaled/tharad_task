import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/session/cubit/app_session_cubit.dart';
import 'package:tharad_task/core/utils/async.dart';
import 'package:tharad_task/features/auth/domain/usecases/login_usecase.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final AppSessionCubit _appSessionCubit;

  LoginCubit(this._loginUseCase, this._appSessionCubit)
    : super(const Async.initial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const Async.loading());

    final result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );

    await result.fold(
      (failure) async {
        emit(Async.failure(failure));
      },
      (entity) async {
        await _appSessionCubit.markAuthenticated();
        emit(Async.success(entity));
      },
    );
  }
}