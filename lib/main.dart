import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharad_task/core/di/di_container.dart';
import 'package:tharad_task/core/hive/hive_registrar.g.dart';
import 'package:tharad_task/features/home/data/models/profile_model.dart';
import 'package:tharad_task/my_app.dart';

const String kProfileBoxName = 'profile_box';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapters();   
  await Hive.openBox<ProfileModel>(kProfileBoxName);

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  await configureDependencies();
  runApp(const MyApp());
}