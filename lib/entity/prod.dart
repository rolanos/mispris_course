import 'package:json_annotation/json_annotation.dart';

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
}
