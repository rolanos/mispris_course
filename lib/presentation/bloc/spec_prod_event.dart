part of 'spec_prod_bloc.dart';

abstract class SpecProdEvent {}

class AddSpecProd extends SpecProdEvent {
  final int? idProd;
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

class EditSpecProd extends SpecProdEvent {
  final int? idProd;
  final int? positionNumber;
  final int? idProdPart;
  final int? quantity;

  EditSpecProd({
    required this.idProd,
    required this.positionNumber,
    required this.idProdPart,
    required this.quantity,
  });
}

class GetAllSpecProds extends SpecProdEvent {}

class CountClassAmount extends SpecProdEvent {
  final int idProd;

  CountClassAmount({required this.idProd});
}

class ShowSpec extends SpecProdEvent {
  final int idProd;

  ShowSpec({required this.idProd});
}
