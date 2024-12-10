import 'package:json_annotation/json_annotation.dart';

part 'prod.g.dart';

///Продукция
@JsonSerializable()
class Prod {
  @JsonKey(name: 'id_prod')
  final int idProd;

  @JsonKey(name: 'short_name')
  final String? shortName;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'id_class')
  final int idClass;

  Prod({
    required this.idProd,
    this.shortName,
    this.name,
    required this.idClass,
  });

  factory Prod.fromJson(Map<String, dynamic> json) => _$ProdFromJson(json);

  Map<String, dynamic> toJson() => _$ProdToJson(this);

  static Map<String, dynamic> toMapAdd(
          String? shortName, String? name, int? idClass) =>
      {
        'short_name': shortName,
        'name': name,
        'id_class': idClass,
      };
}
