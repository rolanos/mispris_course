import 'package:json_annotation/json_annotation.dart';

class ChemClass {
  @JsonKey(name: 'id_class')
  final int idClass;

  @JsonKey(name: 'short_name')
  final String? shortName;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'base_units')
  final int? baseUnits;

  @JsonKey(name: 'main_class')
  final int? mainClass;

  ChemClass(
      {required this.idClass,
      this.shortName,
      this.name,
      this.baseUnits,
      this.mainClass});
}
