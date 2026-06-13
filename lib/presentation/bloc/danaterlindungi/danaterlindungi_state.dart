part of 'danaterlindungi_bloc.dart';

@freezed
class DanaterlindungiState with _$DanaterlindungiState {
  const factory DanaterlindungiState.initial() = _Initial;
  const factory DanaterlindungiState.loading() = _Loading;
  const factory DanaterlindungiState.success(
    List<DanaTerlindungi> data,
    double total,
  ) = _Success;
  const factory DanaterlindungiState.error(String message) = _Error;
}
