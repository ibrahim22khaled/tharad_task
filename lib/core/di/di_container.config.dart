// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/remote_datasources/auth_remote_datasource.dart'
    as _i958;
import '../../features/auth/data/repos/auth_repo_impl.dart' as _i152;
import '../../features/auth/domain/repos/auth_repository.dart' as _i918;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/domain/usecases/verify_otp_usecase.dart' as _i503;
import '../../features/auth/presentation/cubits/login/login_cubit.dart'
    as _i1019;
import '../../features/auth/presentation/cubits/otp/otp_cubit.dart' as _i17;
import '../../features/auth/presentation/cubits/register/register_cubit.dart'
    as _i316;
import '../../features/home/data/datasources/profile_local_datasource.dart'
    as _i1022;
import '../../features/home/data/datasources/profile_remote_datasource.dart'
    as _i410;
import '../../features/home/data/repos/profile_repo_impl.dart' as _i903;
import '../../features/home/domain/repos/profile_repo.dart' as _i1059;
import '../../features/home/domain/usecases/get_profile_usecase.dart' as _i633;
import '../../features/home/domain/usecases/update_profile_usecase.dart'
    as _i640;
import '../../features/home/presentation/cubits/get_profile/get_profile_cubit.dart'
    as _i921;
import '../../features/home/presentation/cubits/update_profile/update_profile_cubit.dart'
    as _i109;
import '../localization/cubit/locale_cubit.dart' as _i635;
import '../network/dio_helper.dart' as _i172;
import '../network/interceptors/auth_interceptor.dart' as _i745;
import '../session/cubit/app_session_cubit.dart' as _i809;
import '../storage/secure_storage_helper.dart' as _i309;
import 'modules/dio_module.dart' as _i983;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final dioModule = _$DioModule();
  gh.lazySingleton<_i558.FlutterSecureStorage>(() => dioModule.secureStorage);
  gh.lazySingleton<_i309.SecureStorageHelper>(
    () => _i309.SecureStorageHelper(gh<_i558.FlutterSecureStorage>()),
  );
  gh.lazySingleton<_i1022.ProfileLocalDataSource>(
    () => _i1022.ProfileLocalDataSourceImpl(),
  );
  gh.lazySingleton<_i745.AuthInterceptor>(
    () => _i745.AuthInterceptor(gh<_i309.SecureStorageHelper>()),
  );
  gh.factory<_i635.LocaleCubit>(
    () => _i635.LocaleCubit(gh<_i460.SharedPreferences>()),
  );
  gh.lazySingleton<_i361.Dio>(() => dioModule.dio(gh<_i745.AuthInterceptor>()));
  gh.lazySingleton<_i172.DioHelper>(() => _i172.DioHelper(gh<_i361.Dio>()));
  gh.lazySingleton<_i410.ProfileRemoteDataSource>(
    () => _i410.ProfileRemoteDataSourceImpl(gh<_i172.DioHelper>()),
  );
  gh.lazySingleton<_i958.AuthRemoteDataSource>(
    () => _i958.AuthRemoteDataSourceImpl(gh<_i172.DioHelper>()),
  );
  gh.lazySingleton<_i918.AuthRepository>(
    () => _i152.AuthRepositoryImpl(
      gh<_i958.AuthRemoteDataSource>(),
      gh<_i309.SecureStorageHelper>(),
    ),
  );
  gh.lazySingleton<_i188.LoginUseCase>(
    () => _i188.LoginUseCase(gh<_i918.AuthRepository>()),
  );
  gh.lazySingleton<_i48.LogoutUseCase>(
    () => _i48.LogoutUseCase(gh<_i918.AuthRepository>()),
  );
  gh.lazySingleton<_i941.RegisterUseCase>(
    () => _i941.RegisterUseCase(gh<_i918.AuthRepository>()),
  );
  gh.lazySingleton<_i503.VerifyOtpUseCase>(
    () => _i503.VerifyOtpUseCase(gh<_i918.AuthRepository>()),
  );
  gh.lazySingleton<_i1059.ProfileRepository>(
    () => _i903.ProfileRepositoryImpl(
      gh<_i410.ProfileRemoteDataSource>(),
      gh<_i1022.ProfileLocalDataSource>(),
    ),
  );
  gh.lazySingleton<_i809.AppSessionCubit>(
    () => _i809.AppSessionCubit(
      gh<_i460.SharedPreferences>(),
      gh<_i309.SecureStorageHelper>(),
      gh<_i48.LogoutUseCase>(),
    ),
  );
  gh.factory<_i316.RegisterCubit>(
    () => _i316.RegisterCubit(gh<_i941.RegisterUseCase>()),
  );
  gh.factory<_i17.OtpCubit>(() => _i17.OtpCubit(gh<_i503.VerifyOtpUseCase>()));
  gh.factory<_i1019.LoginCubit>(
    () => _i1019.LoginCubit(
      gh<_i188.LoginUseCase>(),
      gh<_i809.AppSessionCubit>(),
    ),
  );
  gh.lazySingleton<_i633.GetProfileUseCase>(
    () => _i633.GetProfileUseCase(gh<_i1059.ProfileRepository>()),
  );
  gh.lazySingleton<_i640.UpdateProfileUseCase>(
    () => _i640.UpdateProfileUseCase(gh<_i1059.ProfileRepository>()),
  );
  gh.factory<_i109.UpdateProfileCubit>(
    () => _i109.UpdateProfileCubit(gh<_i640.UpdateProfileUseCase>()),
  );
  gh.factory<_i921.GetProfileCubit>(
    () => _i921.GetProfileCubit(gh<_i633.GetProfileUseCase>()),
  );
  return getIt;
}

class _$DioModule extends _i983.DioModule {}
