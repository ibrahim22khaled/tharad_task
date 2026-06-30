import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/storage/secure_storage_helper.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final SecureStorageHelper _secureStorage;

  AuthInterceptor(this._secureStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await _secureStorage.clearTokens();
    }

    return handler.next(err);
  }
}
