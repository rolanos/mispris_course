part of 'spec_prod_bloc.dart';

@immutable
sealed class SpecProdState {}

class SpecProdInitial extends SpecProdState {
  final List<SpecProd> specProds;

  SpecProdInitial({required this.specProds});
}

class SpecProdError extends SpecProdState {
  final String message;

  SpecProdError({required this.message});
}
