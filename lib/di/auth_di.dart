import 'package:app_demo_flutter/config/app_config/app_config.dart';
import 'package:app_demo_flutter/data/datasource_remote/auth_remote_datasource.dart';
import 'package:app_demo_flutter/data/repository_impl/auth_repository_impl.dart';
import 'package:app_demo_flutter/data/service/auth_service.dart';
import 'package:app_demo_flutter/domain/repositories/auth_repositories.dart';
import 'package:app_demo_flutter/domain/usecases/login_usecase/login_usecase.dart';
import 'package:app_demo_flutter/domain/usecases/logout_usecase/logout_usecase.dart';
import 'package:app_demo_flutter/domain/usecases/register_usecase/logout_usecase.dart';
import 'package:app_demo_flutter/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/logout_cubit/logout_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:get_it/get_it.dart';

void registerDI() {
  final sl = GetIt.instance;
  // Services
  sl.registerLazySingleton<AuthService>(() => AuthService(sl.get(),
      baseUrl: sl.get<String>(instanceName: baseUrlName)));
  // // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      service: sl.get(),
    ),
  );
  // // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteSource: sl.get(),
    ),
  );
  // // UseCases
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl.get()));
  sl.registerLazySingleton(() => LogoutUseCase(authRepository: sl.get()));
  sl.registerLazySingleton(() => RegisterUseCase(authRepository: sl.get()));

  // // bloc
  sl.registerFactory(
      () => LoginCubit(loginUseCase: sl.get(), appSharedPreferences: sl.get()));
  sl.registerFactory(() =>
      LogoutCubit(logoutUseCase: sl.get(), appSharedPreferences: sl.get()));
  sl.registerFactory(() => RegisterCubit(registerUseCase: sl.get()));
}
