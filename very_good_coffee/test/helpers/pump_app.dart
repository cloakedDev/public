import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:very_good_coffee/landing/bloc/coffee_cubit.dart';

class MockCoffeeCubit extends MockCubit<CoffeeState> implements CoffeeCubit {}

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    CoffeeRepository? photosRepository,
    CoffeeCubit? coffeeCubit,
  }) async {
    return mockNetworkImages(
      () async {
        return pumpWidget(
          RepositoryProvider.value(
            value: photosRepository ?? MockCoffeeRepository(),
            child: BlocProvider(
              create: (context) => CoffeeCubit()..grabCoffeeImage(),
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
