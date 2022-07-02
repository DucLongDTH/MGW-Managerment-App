import 'package:app_demo_flutter/data/model/register_request/register_request.dart';
import 'package:app_demo_flutter/domain/usecases/register_usecase/logout_usecase.dart';
import 'package:app_demo_flutter/presentation/cubit/register_cubit/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit({required this.registerUseCase})
      : super(const RegisterState.initial());

  Future<void> register(String fullname, String email, String password) async {
    emit(const RegisterState.loading());
    final listNameSplit = fullname.split(' ');
    final firstName = listNameSplit.last;
    var lastName = '';
    for (int i = 0; i < listNameSplit.length - 1; i++) {
      lastName += listNameSplit[i] + ' ';
    }
    var params = RegisterParams(
        registerRequest: RegisterRequest(
            firstName: firstName,
            lastName: lastName.trim(),
            password: password,
            email: email));
    final response = await registerUseCase.call(params);
    emit(response.fold((error) => RegisterState.error(error), (success) {
      return const RegisterState.success();
    }));
  }
}
