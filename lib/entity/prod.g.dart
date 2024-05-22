// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prod _$ProdFromJson(Map<String, dynamic> json) => Prod(
      idProd: (json['id_prod'] as num).toInt(),
      shortName: json['short_name'] as String?,
      name: json['name'] as String?,
      idClass: (json['id_class'] as num).toInt(),
    );

Map<String, dynamic> _$ProdToJson(Prod instance) => <String, dynamic>{
      'id_prod': instance.idProd,
      'short_name': instance.shortName,
      'name': instance.name,
      'id_class': instance.idClass,
    };
