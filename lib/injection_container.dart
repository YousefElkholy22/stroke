import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mohammed_ashraf/core/utils/api_base_helper.dart';
import 'package:mohammed_ashraf/features/auth/auth_inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

abstract class ServiceLocator {
  static Future<void> init() async {
    sl.allowReassignment = true;
    // Features
    authInject();
    // Core
    injectDioHelper();
    injectSharedPreferences();
  }
}

void injectDioHelper() {
  sl.registerLazySingleton<ApiBaseHelper>(() => ApiBaseHelper(dio: sl()));
  sl.registerLazySingleton(() => Dio());
}

void injectSharedPreferences() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
