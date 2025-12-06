class Predicat {
  final int? id;
  final int idState;
  final int idDec;
  final int? yesPar;

  Predicat({
    this.id,
    required this.idState,
    required this.idDec,
    this.yesPar,
  });

  factory Predicat.fromJson(Map<String, dynamic> json) => Predicat(
        id: json['ID_PRED'],
        idState: json['ID_STATE'],
        idDec: json['ID_DEC'],
        yesPar: json['YES_PAR'],
      );

  Map<String, dynamic> toJson() => {
        'ID_PRED': id,
        'ID_STATE': idState,
        'ID_DEC': idDec,
        'YES_PAR': yesPar,
      };
}
