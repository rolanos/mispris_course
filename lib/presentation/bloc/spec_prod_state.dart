part of 'spec_prod_bloc.dart';

@immutable
sealed class SpecProdState {}

class SpecProdInitial extends SpecProdState {
  final List<SpecProd> specProds;

  SpecProdInitial({required this.specProds});
}

class SpecProdInitialWithMessage extends SpecProdInitial {
  final String message;

  SpecProdInitialWithMessage({
    required super.specProds,
    required this.message,
  });
}

class SpecProdError extends SpecProdState {
  final String message;

  SpecProdError({required this.message});
}
