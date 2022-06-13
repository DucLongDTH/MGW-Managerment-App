import 'package:freezed_annotation/freezed_annotation.dart';

part 'demo_state.freezed.dart';

@freezed
class DemoState with _$DemoState {
  const factory DemoState.initial() = Initial;
  const factory DemoState.loading() = Loading;
  const factory DemoState.success() = Success;
  const factory DemoState.error(Exception failure) = Error;
}
