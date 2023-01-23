import 'package:coffee_repository/coffee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'coffee_state.dart';

class CoffeeCubit extends Cubit<CoffeeState> with ReplayCubitMixin {
  CoffeeCubit() : super(CoffeeInitial());

  String? image;

  Future<void> grabCoffeeImage() async {
    image = await CoffeeRepository().grabImage();

    try {
      emit(CoffeeLoading());
      if (image != null) {
        emit(CoffeeLoaded(image!));
      }
    } catch (e) {
      emit(CoffeeError());
    }
  }

  Future<void> refresh() async {
    image == null;
    grabCoffeeImage();
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
