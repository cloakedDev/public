import 'package:bloc_test/bloc_test.dart';
import 'package:esusu_weather_app/landing/bloc/weather_info_cubit.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockWeatherInfoCubit extends MockCubit<WeatherInfoState> implements WeatherInfoCubit {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
      Widget widget, {
        WeatherRepository? infoRepository,
        WeatherInfoCubit? weatherInfoCubit,
      }) async {
    return mockNetworkImages(
          () async {
        return pumpWidget(
          RepositoryProvider.value(
            value: infoRepository ?? MockWeatherRepository(),
            child: BlocProvider(
              create: (context) => WeatherInfoCubit()..getPermission(),
              child: MaterialApp(
                home: widget,
              ),
            ),
          ),
        );
      },
    );
  }
}
