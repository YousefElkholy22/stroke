import 'package:mohammed_ashraf/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mohammed_ashraf/features/auth/data/datasources/auth_remote_data_sourcec.dart';
import 'package:mohammed_ashraf/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:mohammed_ashraf/features/auth/domain/repositories/auth_repo.dart';
import 'package:mohammed_ashraf/features/auth/domain/usecases/login_use_case.dart';
import 'package:mohammed_ashraf/features/auth/domain/usecases/register_use_case.dart';
import 'package:mohammed_ashraf/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:mohammed_ashraf/features/auth/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:mohammed_ashraf/injection_container.dart';

void authInject() {
  //Cubits
  sl.registerLazySingleton(() => LoginCubit(loginUseCase: sl()));
  sl.registerLazySingleton(() => RegisterCubit(registerUseCase: sl()));

  //UseCases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(authRepo: sl()));
  sl.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(authRepo: sl()));

  //Repositories
  sl.registerLazySingleton<AuthRepo>(() =>
      AuthRepoImpl(authRemoteDataSource: sl(), authLocalDataSource: sl()));

  //DataSources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(apiBaseHelper: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());
}
