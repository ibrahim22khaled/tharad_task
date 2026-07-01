import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/utils/async.dart';
import 'package:tharad_task/core/utils/use_case.dart';
import 'package:tharad_task/features/home/domain/usecases/get_profile_usecase.dart';
import 'get_profile_state.dart';

@injectable
class GetProfileCubit extends Cubit<GetProfileState> {
  final GetProfileUseCase _getProfileUseCase;

  GetProfileCubit(this._getProfileUseCase) : super(const Async.initial());

  Future<void> getProfile() async {
    emit(const Async.loading());

    final result = await _getProfileUseCase(NoParams());

    result.fold(
      (failure) => emit(Async.failure(failure)),
      (entity) => emit(Async.success(entity)),
    );
  }
}