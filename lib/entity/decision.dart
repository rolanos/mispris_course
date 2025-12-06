class Decision {
  final int idTypePr;
  final int idState;
  final int idDec;

  Decision({
    required this.idTypePr,
    required this.idState,
    required this.idDec,
  });

  factory Decision.fromJson(Map<String, dynamic> json) => Decision(
        idTypePr: json['ID_TYPE_PR'],
        idState: json['ID_STATE'],
        idDec: json['ID_DEC'],
      );

  Map<String, dynamic> toJson() => {
        'ID_TYPE_PR': idTypePr,
        'ID_STATE': idState,
        'ID_DEC': idDec,
      };
}
