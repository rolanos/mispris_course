class GroupPerson {
  final int? id;
  final String? name;

  GroupPerson({this.id, this.name});

  factory GroupPerson.fromJson(Map<String, dynamic> json) => GroupPerson(
        id: json['ID_GR'],
        name: json['NAME'],
      );

  Map<String, dynamic> toJson() => {
        'ID_GR': id,
        'NAME': name,
      };
}
