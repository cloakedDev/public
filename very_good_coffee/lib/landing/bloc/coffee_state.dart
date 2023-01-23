part of 'coffee_cubit.dart';

abstract class CoffeeState extends Equatable {
  const CoffeeState();
  @override
  List<Object> get props => [];
}

class CoffeeInitial extends CoffeeState {}

class CoffeeLoading extends CoffeeState {}

class CoffeeLoaded extends CoffeeState {
  const CoffeeLoaded(this.image);

  final String image;

  @override
  List<Object> get props => [image];
}

class CoffeeError extends CoffeeState {}
