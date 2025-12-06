class StateEntity {
  final int idTypePr;
  final int idState;
  final int flagBeg;

  StateEntity({
    required this.idTypePr,
    required this.idState,
    required this.flagBeg,
  });

  factory StateEntity.fromJson(Map<String, dynamic> json) => StateEntity(
        idTypePr: json['ID_TYPE_PR'],
        idState: json['ID_STATE'],
        flagBeg: json['FLAG_BEG'],
      );

  Map<String, dynamic> toJson() => {
        'ID_TYPE_PR': idTypePr,
        'ID_STATE': idState,
        'FLAG_BEG': flagBeg,
      };
}
