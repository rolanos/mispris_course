import 'package:json_annotation/json_annotation.dart';

part 'unit.g.dart';

@JsonSerializable()
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

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);

  static Map<String, dynamic> toMapAdd(
          String? shortName, String? name, String? idClass) =>
      {
        'short_name': shortName,
        'name': name,
        'code': idClass,
      };
}
