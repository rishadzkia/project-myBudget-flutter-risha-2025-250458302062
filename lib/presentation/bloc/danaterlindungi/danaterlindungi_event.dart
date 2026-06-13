part of 'danaterlindungi_bloc.dart';

@freezed
class DanaterlindungiEvent with _$DanaterlindungiEvent {
  const factory DanaterlindungiEvent.started() = _Started;
  const factory DanaterlindungiEvent.getDanaTerlindungi() = _GetDanaTerlindungi;
  const factory DanaterlindungiEvent.createDanaTerlindungi(
      CreateDanaTerlindungiRequestModel model) = _CreateDanaTerlindungi;
}
