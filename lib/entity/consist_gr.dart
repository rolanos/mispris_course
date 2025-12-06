class ConsistGroup {
  final int idGroup;
  final int idPerson;

  ConsistGroup({
    required this.idGroup,
    required this.idPerson,
  });

  factory ConsistGroup.fromJson(Map<String, dynamic> json) => ConsistGroup(
        idGroup: json['ID_GR'],
        idPerson: json['ID_PER'],
      );

  Map<String, dynamic> toJson() => {
        'ID_GR': idGroup,
        'ID_PER': idPerson,
      };
}
