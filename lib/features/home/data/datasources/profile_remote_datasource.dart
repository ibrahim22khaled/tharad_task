import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/core/constants/api_constants.dart';
import 'package:tharad_task/core/network/dio_helper.dart';
import 'package:tharad_task/features/home/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();

  Future<ProfileModel> updateProfile({
    required String username,
    required String email,
    String? password,
    String? newPassword,
    String? newPasswordConfirmation,
    String? imagePath,
  });
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioHelper _dioHelper;

  ProfileRemoteDataSourceImpl(this._dioHelper);

  @override
  Future<ProfileModel> getProfile() async {
    final response = await _dioHelper.get(endpoint: ApiConstants.getProfileUrl);
    return ProfileModel.fromJson(response);
  }

  @override
  Future<ProfileModel> updateProfile({
    required String username,
    required String email,
    String? password,
    String? newPassword,
    String? newPasswordConfirmation,
    String? imagePath,
  }) async {
    final formData = FormData.fromMap({
      'username': username,
      'email': email,
      if (password != null) 'password': password,
      if (newPassword != null) 'new_password': newPassword,
      if (newPasswordConfirmation != null)
        'new_password_confirmation': newPasswordConfirmation,
      '_method': 'PUT',
      if (imagePath != null) 'image': await MultipartFile.fromFile(imagePath),
    });

    final response = await _dioHelper.upload(
      endpoint: ApiConstants.updateProfileUrl,
      formData: formData,
    );

    return ProfileModel.fromJson(response);
  }
}