import 'package:app_demo_flutter/config/app_config/app_config.dart';
import 'package:app_demo_flutter/config/core/shared_preferences.dart';
import 'package:app_demo_flutter/constant/key_utils.dart';
import 'package:app_demo_flutter/data/model/logout_request/logout_request.dart';
import 'package:app_demo_flutter/domain/usecases/logout_usecase/logout_usecase.dart';
import 'package:app_demo_flutter/presentation/cubit/logout_cubit/logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase logoutUseCase;
  final AppSharedPreferences appSharedPreferences;

  LogoutCubit({required this.logoutUseCase, required this.appSharedPreferences})
      : super(const LogoutState.initial());

  Future<void> logout() async {
    final deviceID = await getDeviceID();
    const platform = 'mobile';
    var params = LogoutParams(
        logoutRequest: LogoutRequest(device: deviceID, platform: platform));
    await logoutUseCase.call(params).then((value) async {
      await appSharedPreferences.remove(authTokenKey);
      await appSharedPreferences.remove(refreshTokenKey);
    });
  }
}
