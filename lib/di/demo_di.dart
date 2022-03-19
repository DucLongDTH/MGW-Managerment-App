import 'package:app_demo_flutter/config/app_config/app_config.dart';
import 'package:app_demo_flutter/data/datasource_remote/demo_remote_datasource.dart';
import 'package:app_demo_flutter/data/repository_impl/demo_repository_impl.dart';
import 'package:app_demo_flutter/data/service/demo_service.dart';
import 'package:app_demo_flutter/domain/repositories/demo_repositories.dart';
import 'package:app_demo_flutter/domain/usecases/demo_usecase.dart';
import 'package:app_demo_flutter/presentation/cubit/demo_cubit/demo_cubit.dart';
import 'package:get_it/get_it.dart';

void registerDI() {
  final sl = GetIt.instance;
  // Services
  sl.registerLazySingleton<DemoService>(() => DemoService(sl.get(),
      baseUrl: sl.get<String>(instanceName: baseUrlName)));
  // // Data sources
  sl.registerLazySingleton<DemoRemoteDataSource>(
        () => DemoRemoteDataSourceImpl(
      service: sl.get(),
    ),
  );
  // // Repositories
  sl.registerLazySingleton<DemoRepository>(
        () => DemoRepositoryImpl(
      remoteSource: sl.get(),
    ),
  );
  // // UseCases
  sl.registerLazySingleton(
          () => DemoUseCase(demoRepository: sl.get()));

  // // bloc
  sl.registerFactory(() => DemoCubit(
      demoUseCase: sl.get())
  );
}
