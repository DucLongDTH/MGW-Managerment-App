import 'package:app_demo_flutter/config/app_config/app_config.dart';
import 'package:app_demo_flutter/data/datasource_remote/product_remote_datasource.dart';
import 'package:app_demo_flutter/data/repository_impl/product_repository_impl.dart';
import 'package:app_demo_flutter/data/service/product_service.dart';
import 'package:app_demo_flutter/domain/repositories/product_repositories.dart';
import 'package:app_demo_flutter/domain/usecases/product/get_product_usecase.dart';
import 'package:app_demo_flutter/presentation/cubit/product_cubit/get_product_cubit.dart';
import 'package:get_it/get_it.dart';

void registerDI() {
  final sl = GetIt.instance;
  // Services
  sl.registerLazySingleton<ProductService>(() => ProductService(sl.get(),
      baseUrl: sl.get<String>(instanceName: baseUrlName)));
  // // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(
      service: sl.get(),
    ),
  );
  // // Repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteSource: sl.get(),
    ),
  );
  // // UseCases
  sl.registerLazySingleton(
      () => GetProductUseCase(productRepository: sl.get()));

  // // bloc
  sl.registerFactory(() => GetProductCubit(demoUseCase: sl.get()));
}
