import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:esusu_weather_app/landing/bloc/weather_info_cubit.dart';

void main() {
  group('initial state of WeatherInfoCubit', () {
    WeatherInfoCubit cubit = WeatherInfoCubit();
    setUp(() {
      cubit = WeatherInfoCubit();
    });
    tearDown(() {
      cubit.close();
    });

    test('initial state of WeatherInfoCubit', () {
      expect(cubit.state, WeatherInfoInitial());
    });

    blocTest(
      'loading state of WeatherInfoCubit',
      build: () => cubit,
      act: (cubit) async => cubit.grabWeatherInfo(0.0, 0.0),
      expect: () => [
        WeatherInfoLoading(),
        cubit.state,
      ],
      verify: (_) => cubit.state,
    );

    blocTest(
      'loaded state of WeatherInfoCubit',
      build: () => cubit,
      act: (cubit) async => cubit.emit(const WeatherInfoLoaded([1])),
      expect: () => [
        // const WeatherInfoLoaded([1]),
        cubit.state,
      ],
      verify: (_) => cubit.state,
    );
  });
}