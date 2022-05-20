import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_product_state.freezed.dart';

@freezed
class GetProductState with _$GetProductState {
  const factory GetProductState.initial() = Initial;
  const factory GetProductState.loading() = Loading;
  const factory GetProductState.success(dynamic listDynamic) = Success;
  const factory GetProductState.error(Exception failure) = Error;
}
