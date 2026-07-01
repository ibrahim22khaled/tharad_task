import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/utils/async.dart';
import 'package:tharad_task/features/home/domain/usecases/update_profile_usecase.dart';
import 'update_profile_state.dart';

@injectable
class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;

  UpdateProfileCubit(this._updateProfileUseCase)
      : super(const Async.initial());

  Future<void> updateProfile({
    required String username,
    required String email,
    String? password,
    String? newPassword,
    String? newPasswordConfirmation,
    String? imagePath,
  }) async {
    emit(const Async.loading());

    final result = await _updateProfileUseCase(
      UpdateProfileParams(
        username: username,
        email: email,
        password: password,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
        imagePath: imagePath,
      ),
    );

    result.fold(
      (failure) => emit(Async.failure(failure)),
      (entity) => emit(Async.success(entity)),
    );
  }
}