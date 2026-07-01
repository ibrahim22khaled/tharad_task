import 'package:hive_ce/hive_ce.dart';
import 'package:tharad_task/features/home/data/models/profile_model.dart';

part 'app_hive_registrar.g.dart';

@GenerateAdapters([
  AdapterSpec<ProfileModel>(),
])
class HiveConfig {}