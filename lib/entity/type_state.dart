class TypeState {
  final int? id;
  final String? name;
  final String? shortName;

  TypeState({this.id, this.name, this.shortName});

  factory TypeState.fromJson(Map<String, dynamic> json) => TypeState(
        id: json['ID_STATE'],
        name: json['NAME'],
        shortName: json['SH_NAME'],
      );

  Map<String, dynamic> toJson() => {
        'ID_STATE': id,
        'NAME': name,
        'SH_NAME': shortName,
      };
}
