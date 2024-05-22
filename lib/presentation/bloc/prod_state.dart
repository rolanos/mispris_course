part of 'prod_bloc.dart';

abstract class ProdState {}

class ProdInitial extends ProdState {
  final List<Prod> prods;

  ProdInitial({required this.prods});
}

class ProdError extends ProdState {
  final String message;

  ProdError({required this.message});
}
