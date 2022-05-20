import 'package:app_demo_flutter/domain/usecases/product/get_product_usecase.dart';
import 'package:app_demo_flutter/presentation/cubit/product_cubit/get_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_demo_flutter/config/base_config/base_usecase.dart';

class GetProductCubit extends Cubit<GetProductState> {
  final GetProductUseCase demoUseCase;

  GetProductCubit({required this.demoUseCase})
      : super(const GetProductState.initial());

  Future<void> getData() async {
    emit(const GetProductState.loading());
    Future.delayed(const Duration(milliseconds: 2000), () async {
      var params = NoParams();
      final response = await demoUseCase.call(params);
      emit(response.fold((fail) => GetProductState.error(fail), (success) {
        return const GetProductState.success([]);
      }));
    });
  }
}
