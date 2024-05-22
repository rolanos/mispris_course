// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Unit _$UnitFromJson(Map<String, dynamic> json) => Unit(
      idUnits: (json['id_units'] as num).toInt(),
      shortName: json['short_name'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      'id_units': instance.idUnits,
      'short_name': instance.shortName,
      'name': instance.name,
      'code': instance.code,
    };
