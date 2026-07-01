import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';
import 'package:tharad_task/features/home/data/models/profile_model.dart';

const String kProfileBoxName = 'profile_box';
const String kProfileCacheKey = 'current_profile';

abstract class ProfileLocalDataSource {
  ProfileModel? getCachedProfile();
  Future<void> cacheProfile(ProfileModel profile);
  Future<void> clearCache();
}

@LazySingleton(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  Box<ProfileModel> get _box => Hive.box<ProfileModel>(kProfileBoxName);

  @override
  ProfileModel? getCachedProfile() => _box.get(kProfileCacheKey);

  @override
  Future<void> cacheProfile(ProfileModel profile) =>
      _box.put(kProfileCacheKey, profile);

  @override
  Future<void> clearCache() => _box.delete(kProfileCacheKey);
}