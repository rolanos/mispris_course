class ProcessEntity {
  final int? id;
  final String? name;
  final String? shortName;
  final int? typePr;
  final int? idClass;

  ProcessEntity({
    this.id,
    this.name,
    this.shortName,
    this.typePr,
    this.idClass,
  });

  factory ProcessEntity.fromJson(Map<String, dynamic> json) => ProcessEntity(
        id: json['ID_PROCESS'],
        name: json['NAME'],
        shortName: json['SH_NAME'],
        typePr: json['TYPE_PR'],
        idClass: json['ID_CLASS'],
      );

  Map<String, dynamic> toJson() => {
        'ID_PROCESS': id,
        'NAME': name,
        'SH_NAME': shortName,
        'TYPE_PR': typePr,
        'ID_CLASS': idClass,
      };
}
