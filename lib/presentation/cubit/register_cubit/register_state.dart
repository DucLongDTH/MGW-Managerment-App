import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = Initial;
  const factory RegisterState.loading() = Loading;
  const factory RegisterState.success() = Success;
  const factory RegisterState.error(Exception failure) = Error;
}
