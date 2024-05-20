import 'package:json_annotation/json_annotation.dart';

class Unit {
  @JsonKey(name: 'id_units')
  final int idUnits;

  @JsonKey(name: 'short_name')
  final String? shortName;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'code')
  final String? code;

  Unit({required this.idUnits, this.shortName, this.name, this.code});
}
