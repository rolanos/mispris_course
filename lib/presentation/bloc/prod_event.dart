part of 'prod_bloc.dart';

abstract class ProdEvent {}

class AddProd extends ProdEvent {
  final String? shortName;
  final String? name;
  final int? idClass;

  AddProd({required this.shortName, required this.name, required this.idClass});
}

class DeleteProd extends ProdEvent {
  final int? productId;

  DeleteProd({
    required this.productId,
  });
}

class GetAllProds extends ProdEvent {}
