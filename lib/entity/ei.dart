class EI {
  final int? idEi;
  final String? code;
  final String? shortName;
  final String? name;

  EI({
    this.idEi,
    this.code,
    this.shortName,
    this.name,
  });

  factory EI.fromJson(Map<String, dynamic> json) => EI(
        idEi: json['ID_EI'],
        code: json['CODE'],
        shortName: json['SHORT_NAME'],
        name: json['NAME'],
      );

  Map<String, dynamic> toJson() => {
        'ID_EI': idEi,
        'CODE': code,
        'SHORT_NAME': shortName,
        'NAME': name,
      };
}
