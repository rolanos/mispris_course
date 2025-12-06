class ChemClass {
  final int? id;
  final String? name;
  final String? shortName;
  final int? baseEi;
  final int? mainClass;

  ChemClass({
    this.id,
    this.name,
    this.shortName,
    this.baseEi,
    this.mainClass,
  });

  factory ChemClass.fromJson(Map<String, dynamic> json) => ChemClass(
        id: json['ID_CLASS'],
        name: json['NAME'],
        shortName: json['SHORT_NAME'],
        baseEi: json['BASE_EI'],
        mainClass: json['MAIN_CLASS'],
      );

  Map<String, dynamic> toJson() => {
        'ID_CLASS': id,
        'NAME': name,
        'SHORT_NAME': shortName,
        'BASE_EI': baseEi,
        'MAIN_CLASS': mainClass,
      };
}
