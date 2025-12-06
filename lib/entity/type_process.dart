class TypeProcess {
  final int? id;
  final String? name;
  final String? shortName;
  final int idClass;

  TypeProcess({
    this.id,
    this.name,
    this.shortName,
    required this.idClass,
  });

  factory TypeProcess.fromJson(Map<String, dynamic> json) => TypeProcess(
        id: json['ID_TYPE_PROC'],
        name: json['NAME'],
        shortName: json['SH_NAME'],
        idClass: json['ID_CLASS'],
      );

  Map<String, dynamic> toJson() => {
        'ID_TYPE_PROC': id,
        'NAME': name,
        'SH_NAME': shortName,
        'ID_CLASS': idClass,
      };
}
