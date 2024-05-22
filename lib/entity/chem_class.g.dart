// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chem_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChemClass _$ChemClassFromJson(Map<String, dynamic> json) => ChemClass(
      idClass: (json['id_class'] as num).toInt(),
      shortName: json['short_name'] as String?,
      name: json['name'] as String?,
      baseUnits: (json['base_units'] as num?)?.toInt(),
      mainClass: (json['main_class'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ChemClassToJson(ChemClass instance) => <String, dynamic>{
      'id_class': instance.idClass,
      'short_name': instance.shortName,
      'name': instance.name,
      'base_units': instance.baseUnits,
      'main_class': instance.mainClass,
    };
