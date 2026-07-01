import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharad_task/core/storage/secure_storage_helper.dart';
import 'package:tharad_task/core/utils/use_case.dart';
import 'package:tharad_task/features/auth/domain/usecases/logout_usecase.dart';

part 'app_session_state.dart';

@lazySingleton
class AppSessionCubit extends Cubit<AppSessionState> {
  final SharedPreferences _prefs;
  final SecureStorageHelper _secureStorage;
  final LogoutUseCase _logoutUseCase;
  static const _key = 'is_logged_in';

  AppSessionCubit(this._prefs, this._secureStorage, this._logoutUseCase)
    : super(const AppSessionLoading()) {
    _checkSession();
  }

  Future<void> _checkSession() async {
    final results = await Future.wait([
      Future.delayed(const Duration(seconds: 4)),
      _validate(),
    ]);

    final isAuthenticated = results[1] as bool;
    if (isAuthenticated) {
      emit(const AppSessionAuthenticated());
    } else {
      emit(const AppSessionUnauthenticated());
    }
  }

  Future<void> markAuthenticated() async {
    await _prefs.setBool(_key, true);
    emit(const AppSessionAuthenticated());
  }

  Future<void> logout() async {
    await _logoutUseCase( NoParams());
    await _prefs.setBool(_key, false);
    emit(const AppSessionUnauthenticated());
  }

  Future<bool> _validate() async {
    final isLoggedIn = _prefs.getBool(_key) ?? false;
    final hasToken = await _secureStorage.hasAccessToken();

    if (!isLoggedIn) {
      await _prefs.setBool(_key, false);
    }

    return isLoggedIn && hasToken;
  }
}