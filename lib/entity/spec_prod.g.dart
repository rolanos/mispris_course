// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spec_prod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecProd _$SpecProdFromJson(Map<String, dynamic> json) => SpecProd(
      idProd: (json['id_prod'] as num).toInt(),
      positionNumber: (json['position_number'] as num?)?.toInt(),
      idProdPart: (json['id_prod_part'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SpecProdToJson(SpecProd instance) => <String, dynamic>{
      'id_prod': instance.idProd,
      'position_number': instance.positionNumber,
      'id_prod_part': instance.idProdPart,
      'quantity': instance.quantity,
    };
