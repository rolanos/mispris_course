import 'package:json_annotation/json_annotation.dart';

part 'spec_prod.g.dart';

//Спецификация продукции
@JsonSerializable()
class SpecProd {
  @JsonKey(name: 'id_prod')
  final int idProd;

  @JsonKey(name: 'position_number')
  final int? positionNumber;

  @JsonKey(name: 'id_prod_part')
  final int? idProdPart;

  @JsonKey(name: 'quantity')
  final int? quantity;

  SpecProd(
      {required this.idProd,
      this.positionNumber,
      this.idProdPart,
      this.quantity});

  factory SpecProd.fromJson(Map<String, dynamic> json) =>
      _$SpecProdFromJson(json);

  Map<String, dynamic> toJson() => _$SpecProdToJson(this);
}
