part of 'spec_prod_bloc.dart';

abstract class SpecProdEvent {}

class AddSpecProd extends SpecProdEvent {
  final int idProd;
  final int? positionNumber;
  final int? idProdPart;
  final int? quantity;

  AddSpecProd({
    required this.idProd,
    required this.positionNumber,
    required this.idProdPart,
    required this.quantity,
  });
}

class DeleteSpecProd extends SpecProdEvent {
  final int? idProd;

  DeleteSpecProd({
    required this.idProd,
  });
}

class GetAllSpecProds extends SpecProdEvent {}
