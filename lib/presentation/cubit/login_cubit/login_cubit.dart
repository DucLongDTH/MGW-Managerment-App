import 'package:app_demo_flutter/config/app_config/app_config.dart';
import 'package:app_demo_flutter/config/core/shared_preferences.dart';
import 'package:app_demo_flutter/constant/key_utils.dart';
import 'package:app_demo_flutter/data/model/login_request/login_request.dart';
import 'package:app_demo_flutter/domain/usecases/login_usecase/login_usecase.dart';
import 'package:app_demo_flutter/presentation/cubit/login_cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final AppSharedPreferences appSharedPreferences;

  LoginCubit({required this.loginUseCase, required this.appSharedPreferences})
      : super(const LoginState.initial());

  Future<void> login(String username, String password) async {
    emit(const LoginState.loading());
    final deviceID = await getDeviceID();
    const platform = 'mobile';
    var params = LoginParams(
        loginRequest: LoginRequest(
            email: username,
            password: password,
            device: deviceID,
            platform: platform));
    final response = await loginUseCase.call(params);
    emit(response.fold((fail) => LoginState.error(fail), (success) {
      appSharedPreferences.setString(
          authTokenKey, success.data?.accessToken ?? '');
      appSharedPreferences.setString(
          refreshTokenKey, success.data?.refreshToken ?? '');
      return const LoginState.success();
    }));
  }
}
