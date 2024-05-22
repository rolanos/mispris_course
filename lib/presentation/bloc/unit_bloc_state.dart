part of 'unit_bloc_bloc.dart';

abstract class UnitState {}

class UnitInitial extends UnitState {
  final List<Unit> units;

  UnitInitial({required this.units});
}

class UnitError extends UnitState {
  final String message;

  UnitError({required this.message});
}
