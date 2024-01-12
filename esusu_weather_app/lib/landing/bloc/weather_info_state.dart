part of 'weather_info_cubit.dart';

abstract class WeatherInfoState extends Equatable {
  const WeatherInfoState();
  @override
  List<Object> get props => [];
}

class WeatherInfoInitial extends WeatherInfoState {}

class WeatherInfoLoading extends WeatherInfoState {}

class WeatherInfoLoaded extends WeatherInfoState {
  const WeatherInfoLoaded(this.info);

  final List<dynamic>? info;

  @override
  List<Object> get props => [info!];
}

class WeatherInfoError extends WeatherInfoState {}