import 'package:json_annotation/json_annotation.dart';

part 'chem_class.g.dart';

@JsonSerializable()
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

  factory ChemClass.fromJson(Map<String, dynamic> json) =>
      _$ChemClassFromJson(json);

  Map<String, dynamic> toJson() => _$ChemClassToJson(this);

  static Map<String, dynamic> toMapAdd(
          String? shortName, String? name, int? baseUnits, int? mainClass) =>
      {
        'short_name': shortName,
        'name': name,
        'base_units': baseUnits,
        'main_class': mainClass,
      };
}
