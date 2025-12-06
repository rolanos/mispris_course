class Person {
  final int? id;
  final String? fio;

  Person({this.id, this.fio});

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json['ID_PER'],
        fio: json['FIO'],
      );

  Map<String, dynamic> toJson() => {
        'ID_PER': id,
        'FIO': fio,
      };
}
