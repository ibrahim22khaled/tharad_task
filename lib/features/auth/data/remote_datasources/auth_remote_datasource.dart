import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/constants/api_constants.dart';
import 'package:tharad_task/core/network/dio_helper.dart';
import 'package:tharad_task/features/auth/data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> register({
    required String email,
    required String username,
    required String password,
    required String passwordConfirmation,
    required String imagePath,
  });

  Future<void> verifyOtp({
    required String email,
    required String otp,
  });

  Future<AuthModel> login({
    required String email,
    required String password,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioHelper _dioHelper;

  AuthRemoteDataSourceImpl(this._dioHelper);

  @override
  Future<AuthModel> register({
    required String email,
    required String username,
    required String password,
    required String passwordConfirmation,
    required String imagePath,
  }) async {
    final formData = FormData.fromMap({
      'email': email,
      'username': username,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'image': await MultipartFile.fromFile(imagePath),
    });

    final response = await _dioHelper.upload(
      endpoint: ApiConstants.registerUrl,
      formData: formData,
    );

    return AuthModel.fromJson(response);
  }

  @override
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    await _dioHelper.get(
      endpoint: ApiConstants.otpUrl,
      queryParameters: {'email': email, 'otp': otp},
    );
  }

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    final formData = FormData.fromMap({
      'email': email,
      'password': password,
    });

    final response = await _dioHelper.upload(
      endpoint: ApiConstants.loginUrl,
      formData: formData,
    );

    return AuthModel.fromJson(response);
  }
}