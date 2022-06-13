import 'package:app_demo_flutter/config/base_config/base_usecase.dart';
import 'package:app_demo_flutter/domain/usecases/demo_usecase.dart';
import 'package:app_demo_flutter/presentation/cubit/demo_cubit/demo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemoCubit extends Cubit<DemoState> {
  final DemoUseCase demoUseCase;

  DemoCubit({required this.demoUseCase}) : super(const DemoState.initial());

  Future<void> getData() async {
    emit(const DemoState.loading());
    var params = NoParams();
    final response = await demoUseCase.call(params);
    emit(response.fold((fail) => DemoState.error(fail), (success) {
      return const DemoState.success();
    }));
  }
}
