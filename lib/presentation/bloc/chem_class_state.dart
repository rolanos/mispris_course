part of 'chem_class_bloc.dart';

@immutable
sealed class ChemClassState {}

class ChemClassInitial extends ChemClassState {
  final List<ChemClass> chems;

  ChemClassInitial({required this.chems});
}

class ChemClassError extends ChemClassState {
  final String message;

  ChemClassError({required this.message});
}
