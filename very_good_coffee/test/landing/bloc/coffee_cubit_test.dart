import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee/landing/bloc/coffee_cubit.dart';

void main() {
  group('initial state of CoffeeCubit', () {
    CoffeeCubit cubit = CoffeeCubit();
    setUp(() {
      cubit = CoffeeCubit();
    });
    tearDown(() {
      cubit.close();
    });

    test('initial state of CoffeeCubit', () {
      expect(cubit.state, CoffeeInitial());
    });

    blocTest(
      'loading state of CoffeeCubit',
      build: () => cubit,
      act: (cubit) async => cubit.grabCoffeeImage(),
      expect: () => [
        CoffeeLoading(),
        cubit.state,
      ],
      verify: (_) => cubit.state,
    );
  });
}
