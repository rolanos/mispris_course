class TypeDecision {
  final int? id;
  final String? name;
  final String? shortName;

  TypeDecision({this.id, this.name, this.shortName});

  factory TypeDecision.fromJson(Map<String, dynamic> json) => TypeDecision(
        id: json['ID_DEC'],
        name: json['NAME'],
        shortName: json['SH_NAME'],
      );

  Map<String, dynamic> toJson() => {
        'ID_DEC': id,
        'NAME': name,
        'SH_NAME': shortName,
      };
}
